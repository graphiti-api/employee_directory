require 'rails_helper'

RSpec.describe PostResource, type: :resource do
  around do |e|
    original = Post::DATA.deep_dup
    e.run
    Post.const_set('DATA', original)
  end

  describe 'serialization' do
    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(1)
      expect(data.jsonapi_type).to eq('posts')
      expect(data.title).to eq('Graphiti')
    end
  end

  describe 'filtering' do
    context 'by id' do
      before do
        params[:filter] = { id: { eq: '3' } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([3])
        expect(d.map(&:title)).to eq(['super'])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([1,2,3,4])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([4,3,2,1])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
