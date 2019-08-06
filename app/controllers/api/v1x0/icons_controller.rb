module Api
  module V1x0
    class IconsController < ApplicationController
      include Api::V1x0::Mixins::IndexMixin

      def show
        render :json => Icon.find(params.require(:id))
      end

      def create
        icon = Catalog::CreateIcon.new(icon_params).process.icon
        render :json => icon
      end

      def destroy
        Catalog::SoftDelete.new(Icon.find(params.require(:id))).process
        head :no_content
      end

      def update
        icon = Icon.find(params.require(:id))
        icon.update!(icon_patch_params)

        render :json => icon
      end

      def raw_icon
        icon = find_icon(params.permit(:icon_id, :portfolio_item_id))
        image = Image.find(icon.image_id)
        send_data(image.content,
                  :type        => MimeMagic.by_magic(image.content).type,
                  :disposition => 'inline')
      end

      def override_icon
        overriden_icon = Catalog::OverrideIcon.new(params.require(:icon_id), params.require(:portfolio_item_id))
        render :json => overriden_icon.process.icon
      end

      private

      def icon_params
        params.require(:content)
        params.require(:filename)
        icon_patch_params
      end

      def icon_patch_params
        params.permit(:content, :filename, :source_ref, :source_id, :portfolio_item_id)
      end

      def find_icon(ids)
        ids[:icon_id].present? ? Icon.find(ids[:icon_id]) : Icon.find_by!(:portfolio_item_id => ids[:portfolio_item_id])
      end
    end
  end
end
