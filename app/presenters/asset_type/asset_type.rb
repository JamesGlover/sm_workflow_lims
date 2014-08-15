require './app/presenters/presenter'

module Presenter::AssetTypePresenter
  class AssetType < Presenter

    attr_reader :asset_type

    def initialize(asset_type)
      @asset_type = asset_type
    end

    def name
      asset_type.name
    end

    def identifier
      asset_type.identifier_type
    end

    def sample_count?
      yield if asset_type.has_sample_count
    end

    def id
      asset_type.id
    end

    def type
      asset_type.name.split.first
    end

    def template_name
      asset_type.name.downcase.gsub(' ','_')
    end

    def validates_with
      {
        'alphanumeric' => '^\w+$',
        'numeric'      => '^\d+$'
      }[asset_type.identifier_data_type]
    end

    def asset_fields
      sample_count = asset_type.has_sample_count ? :sample_count : nil
      [:identifier, :study, :batch_id, sample_count, :workflow, :created_at, :completed_at].compact
    end

  end
end
