require 'rails_helper'

RSpec.describe CreateActivity do

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:activity) { build(:activity) }
  let(:invalid_activity) { build(:invalid_activity) }

  describe '#run' do
    it 'returns true when the activity is valid' do
      create_activity_workflow = CreateActivity.new(activity)
      expect(create_activity_workflow.run).to be_truthy
    end
    it 'returns false when the activity is invalid' do
      create_activity_workflow = CreateActivity.new(invalid_activity)
      expect(create_activity_workflow.run).to be_falsy
    end
  end

  describe '#message' do
    it "is 'not yet saved' when the workflow has not run" do
      create_activity_workflow = CreateActivity.new(activity)
      expect(create_activity_workflow.message).to match(/not yet saved/)
    end
  end

  context 'without an author' do
    describe '#message' do
      it "is 'is pending review' when the workflow is run without an author" do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run
        expect(create_activity_workflow.message).to match(/is pending review/)
      end
    end

    describe 'activity state' do
      it 'is pending' do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run
        expect(create_activity_workflow.activity.state).to eq('pending')
      end
    end

    describe 'activity author' do
      it 'is nil' do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run
        expect(create_activity_workflow.activity.author).to be_nil
      end
    end
  end

  context 'with a regular user author' do
    describe '#message' do
      it "is 'pending review'" do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run(user)
        expect(create_activity_workflow.message).to match(/pending review/)
      end
    end

    describe 'activity state' do
      it 'is pending' do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run(user)
        expect(create_activity_workflow.activity.state).to eq('pending')
      end
    end

    describe 'activity author' do
      it 'is the workflow author' do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run(user)
        expect(create_activity_workflow.activity.author).to eq(user)
      end
    end
  end

  context 'with an admin author' do
    describe '#message' do
      it "is 'successfully created'" do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run(admin)
        expect(create_activity_workflow.message).to match(/successfully created/)
      end
    end

    describe 'activity state' do
      it 'is active' do
        create_activity_workflow = CreateActivity.new(activity)
        create_activity_workflow.run(admin)
        expect(create_activity_workflow.activity.state).to eq('active')
      end
    end
  end
end

