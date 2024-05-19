# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/model/image'

describe Model::Image do
  let(:input) do
    {
      url: 'images.com/img1',
      photographer: 'John Doe'
    }
  end

  describe '#data' do
    subject do
      Model::Image.new(input).data
    end

    it 'has data wih full structure' do
      expect(subject).to eq(
        {
          url: 'images.com/img1',
          caption: nil
        }
      )
    end

    it 'removes unsupported data' do
      expect(subject[:photographer]).to be_nil
    end
  end

  describe 'validations' do
    it 'rejects when :url is not given' do
      expect do
        Model::Image.new(input.merge(url: ''))
      end.to raise_error(':url must be present')

      expect do
        Model::Image.new(input.merge(url: nil))
      end.to raise_error(':url must be present')
    end
  end
end
