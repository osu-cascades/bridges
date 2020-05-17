require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:organization) { create(:organization) }

  describe '#index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'orders organizations by name' do
      @organization_c = create(:organization, name: 'Corn')
      @organization_a = create(:organization, name: 'Avocado')
      @organization_b = create(:organization, name: 'Biscuit')

      get :index, params: { format: :json }
      organizations = JSON.parse(response.body)['organizations']
      expect(organizations[0].fetch('name')).to eq('Avocado')
      expect(organizations[1].fetch('name')).to eq('Biscuit')
      expect(organizations[2].fetch('name')).to eq('Corn')
    end

    context 'with filter parameters' do
      before do
        @bend_organization = create(:organization, tag_list: 'bend')
        @redmond_organization = create(:organization, tag_list: 'redmond')
        @sisters_organization = create(:organization, tag_list: 'sisters')
      end

      it 'returns organizations based on tags parameter' do
        get :index, params: { tags: ['bend', 'redmond'], format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['organizations'].length).to eq(2)
      end

      it 'returns organizations based on search parameter' do
        @sisters_organization.programs = 'After school activities'
        @sisters_organization.save
        get :index, params: { search: 'school', format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['organizations'].length).to eq(1)
      end

      it 'is case insensitive' do
        @sisters_organization.programs = 'After sChOOL activities are COOL'
        @sisters_organization.save
        get :index, params: { search: 'SCHOOL', format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['organizations'].length).to eq(1)
      end
    end
  end

  describe '#show' do
    it 'returns http success' do
      get :show, params: { id: organization.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#new' do
    context 'logged in as admin' do
      login_admin

      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'logged in as guest' do
      login_user

      it 'redirects to root' do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      it 'redirects to sign_in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#edit' do
    context 'logged in as admin' do
      login_admin

      it 'returns http success' do
        get :edit, params: { id: organization.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'logged in as guest' do
      login_user

      it 'redirects to root' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      it 'returns http success' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    context 'logged in as admin' do
      login_admin

      context 'with valid attributes' do
        it 'creates new organizations' do
          organization_params = FactoryBot.attributes_for(:organization)
          expect { post :create, params: { organization: organization_params } }.to change(Organization, :count).by(1)
        end

        it 'redirects to index' do
          post :create, params: { organization: FactoryBot.attributes_for(:organization) }
          expect(response).to redirect_to organizations_path
        end

        it 'produces correct flash notice' do
          post :create, params: { organization: FactoryBot.attributes_for(:organization) }
          assert_equal 'Organization was successfully created.', flash[:success]
        end
      end

      context 'with invalid attributes' do
        it 'does not save new organization' do
          organization_params = FactoryBot.attributes_for(:invalid_organization)
          expect { post :create, params: { organization: organization_params } }.to_not change(Organization, :count)
        end

        it 'does not redirect to index' do
          post :create, params: { organization: FactoryBot.attributes_for(:invalid_organization) }
          expect(response).to_not redirect_to organizations_path
        end
      end
    end

    context 'logged in as guest' do
      login_user

      it 'redirects to root and does not create organization' do
        organization_params = FactoryBot.attributes_for(:organization)
        expect { post :create, params: { organization: organization_params } }.to change(Organization, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      it 'redirects to sign_in and does not create organization' do
        organization_params = FactoryBot.attributes_for(:organization)
        expect { post :create, params: { organization: organization_params } }.to change(Organization, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    context 'logged in as admin' do
      login_admin

      before do
        @organization = create(:organization)
      end

      context 'with valid attributes' do
        it 'updates organization attributes' do
          put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization, name: 'Lettuce NOT Taco Bout It') }
          @organization.reload
          expect(@organization.name).to eq('Lettuce NOT Taco Bout It')
        end

        it 'redirects to the updated organization' do
          put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization) }
          expect(response).to redirect_to @organization
        end

        it 'produces correct flash notice' do
          post :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization, name: 'Lettuce NOT Taco Bout It') }
          assert_equal 'Organization was successfully updated.', flash[:success]
        end
      end

      context 'with invalid attributes' do
        it 'does not update attributes' do
          put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:invalid_organization) }
        end

        it 'does not redirect to updated organization' do
          put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:invalid_organization) }
          expect(response).to_not redirect_to @organization
        end
      end
    end

    context 'logged in as guest' do
      login_user

      before do
        @organization = create(:organization)
      end

      it 'redirects to root and does not update organization attributes' do
        put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization, name: 'Lettuce NOT Taco Bout It') }
        expect(response).to redirect_to root_path
      end
    end

    context 'not logged in' do
      before do
        @organization = create(:organization)
      end

      it 'redirects to sign_in and does not update organization attributes' do
        put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization, name: 'Lettuce NOT Taco Bout It') }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'logged in as admin' do
      login_admin

      before do
        @organization = create(:organization)
      end

      it 'deletes organization' do
        expect { delete :destroy, params: { id: @organization } }.to change(Organization, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: @organization }
        expect(response).to redirect_to organizations_url
      end

      it 'produces correct flash notice' do
        delete :destroy, params: { id: @organization }
        assert_equal 'Organization was successfully destroyed.', flash[:success]
      end
    end
  end

  context 'logged in as guest' do
    login_user

    before do
      @organization = create(:organization)
    end

    it 'redirects to root and does not delete organization' do
      expect { delete :destroy, params: { id: @organization } }.to change(Organization, :count).by(0)
      expect(response).to redirect_to root_path
    end
  end

  context 'not logged in' do
    before do
      @organization = create(:organization)
    end

    it 'redirects to sign_in and does not delete organization' do
      expect { delete :destroy, params: { id: @organization } }.to change(Organization, :count).by(0)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
