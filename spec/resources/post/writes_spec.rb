require 'rails_helper'

RSpec.describe PostResource, type: :resource do
  around do |e|
    original = Post::DATA.deep_dup
    e.run
    Post.const_set('DATA', original)
  end

  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'posts',
          attributes: { title: 'new' }
        }
      }
    end

    let(:instance) do
      PostResource.build(payload)
    end

    it 'works' do
      expect(instance.save).to eq(true)
      expect(Post::DATA.last).to eq(id: 5, title: 'new')
    end
  end

  describe 'updating' do
    let(:payload) do
      {
        data: {
          id: '3',
          type: 'posts',
          attributes: { title: 'updated' }
        }
      }
    end

    let(:instance) do
      PostResource.find(payload)
    end

    it 'works' do
      expect(instance.update_attributes).to eq(true)
      expect(Post::DATA[2][:title]).to eq('updated')
    end
  end

  describe 'destroying' do
    let(:instance) do
      PostResource.find(id: '3')
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Post::DATA.length }.by(-1)
      found = Post::DATA.find { |d| d[:id].to_s == '3' }
      expect(found).to be_nil
    end
  end
end
