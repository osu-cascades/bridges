require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:activity) { create(:activity) }

  describe '#index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets display attributes to when_start and location' do
      get :index, params: { format: :json }
      expect(JSON.parse(response.body)['display_attributes'].to_hash.symbolize_keys).to eq({ when_start: 'Time', location: 'Location' })
    end

    context 'with filter parameters' do
      before do
        @free_activity = create(:activity, tag_list: 'free', state: :active)
        @food_activity = create(:activity, tag_list: 'food', state: :active)
        @other_activity = create(:activity, tag_list: 'other', state: :active)
      end

      it 'returns activities based on tags parameter' do
        get :index, params: { tags: ['food', 'free'], format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['activities'].length).to eq(2)
      end

      it 'returns activities based on search parameter' do
        @other_activity.description = 'Cool beans will be provided'
        @other_activity.save
        get :index, params: { search: 'beans', format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['activities'].length).to eq(1)
      end

      it 'is case insensitive' do
        @other_activity.description = 'Cool bEaNS of all sizes will be provided'
        @other_activity.save
        get :index, params: { search: 'BEANS', format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['activities'].length).to eq(1)
      end
    end
  end

  describe '#show' do
    it 'returns http success' do
      get :show, params: { id: activity.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#new' do
    login_admin

    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#edit' do
    context 'logged in as admin' do
      login_admin

      it 'returns http success' do
        get :edit, params: { id: activity.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'logged in as guest' do
      login_user

      it 'redirects to root' do
        get :edit, params: { id: activity.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      it 'redirects to sign_in' do
        get :edit, params: { id: activity.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    login_admin

    context 'with valid attributes' do
      it 'creates new activities' do
        activity_params = FactoryBot.attributes_for(:activity)
        expect { post :create, params: { activity: activity_params } }.to change(Activity, :count).by(1)
      end

      it 'redirects to index' do
        post :create, params: { activity: FactoryBot.attributes_for(:activity) }
        expect(response).to redirect_to activities_path
      end

      it 'produces correct flash notice' do
        post :create, params: { activity: FactoryBot.attributes_for(:activity) }
        assert_equal 'Activity was successfully created.', flash[:success]
      end
    end

    context 'with invalid attributes' do
      it 'does not save new activity' do
        activity_params = FactoryBot.attributes_for(:invalid_activity)
        expect { post :create, params: { activity: activity_params } }.to_not change(Activity, :count)
      end

      it 'does not redirect to index' do
        post :create, params: { activity: FactoryBot.attributes_for(:invalid_activity) }
        expect(response).to_not redirect_to activities_path
      end
    end
  end

  describe '#update' do
    context 'logged in as admin' do
      login_admin

      before do
        @activity = create(:activity)
      end

      context 'with valid attributes' do
        it 'updates activity attributes' do
          put :update, params: { id: @activity, activity: FactoryBot.attributes_for(:activity, title: 'Tacos') }
          @activity.reload
          expect(@activity.title).to eq('Tacos')
        end

        it 'redirects to the updated activity' do
          put :update, params: { id: @activity, activity: FactoryBot.attributes_for(:activity) }
          expect(response).to redirect_to @activity
        end

        it 'produces correct flash notice' do
          post :update, params: { id: @activity, activity: FactoryBot.attributes_for(:activity, title: 'Tacos') }
          assert_equal 'Activity was successfully updated.', flash[:success]
        end
      end

      context 'with invalid attributes' do
        it 'does not update attributes' do
          put :update, params: { id: @activity, activity: FactoryBot.attributes_for(:invalid_activity) }
          @activity.reload
          expect(@activity.title).to eq('Lettuce Taco Bout It FUNdraiser')
        end

        it 'does not redirect to updated activity' do
          put :update, params: { id: @activity, activity: FactoryBot.attributes_for(:invalid_activity) }
          expect(response).to_not redirect_to @activity
        end
      end
    end

    context 'logged in as guest' do
      login_user

      before do
        @activity = create(:activity)
      end

      it 'redirects to root and does not update activity' do
        put :update, params: { id: @activity, activity: FactoryBot.attributes_for(:activity, title: 'Tacos') }
        @activity.reload
        expect(@activity.title).to eq('Lettuce Taco Bout It FUNdraiser')
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      before do
        @activity = create(:activity)
      end

      it 'redirects to sign_in and does not update activity' do
        put :update, params: { id: @activity, activity: FactoryBot.attributes_for(:activity, title: 'Tacos') }
        @activity.reload
        expect(@activity.title).to eq('Lettuce Taco Bout It FUNdraiser')
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'logged in as admin' do
      login_admin

      before do
        @activity = create(:activity)
      end

      it 'deletes activity' do
        expect { delete :destroy, params: { id: @activity } }.to change(Activity, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: @activity }
        expect(response).to redirect_to activities_url
      end

      it 'produces correct flash notice' do
        delete :destroy, params: { id: @activity }
        assert_equal 'Activity was successfully destroyed.', flash[:success]
      end
    end

    context 'logged in as guest' do
      login_user

      before do
        @activity = create(:activity)
      end

      it 'redirects to root and does not delete activity' do
        expect { delete :destroy, params: { id: @activity } }.to change(Activity, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      before do
        @activity = create(:activity)
      end

      it 'redirects to sign_in and does not delete activity' do
        expect { delete :destroy, params: { id: @activity } }.to change(Activity, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
