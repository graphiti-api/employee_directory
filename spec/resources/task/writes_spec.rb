require 'rails_helper'

RSpec.describe TaskResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'features',
          attributes: { }
        }
      }
    end

    let(:instance) do
      TaskResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true)
      }.to change { Feature.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:task) { create(:task) }

    let(:payload) do
      {
        data: {
          id: task.id.to_s,
          type: 'tasks',
          attributes: { title: 'changed!' }
        }
      }
    end

    let(:instance) do
      TaskResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { task.reload.updated_at }
       .and change { task.title }.to('changed!')
    end
  end

  describe 'destroying' do
    let!(:task) { create(:task) }

    let(:instance) do
      TaskResource.find(id: task.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Task.count }.by(-1)
    end
  end
end
