module Admin
  class BadgesController < Admin::ApplicationController
    layout "admin"

    def index
      @badges = Badge.all
    end

    def new
      @badge = Badge.new
    end

    def edit
      @badge = Badge.find(params[:id])
    end

    def create
      @badge = Badge.new(badge_params)

      if @badge.save
        flash[:success] = I18n.t("admin.badges_controller.created")
        redirect_to admin_badges_path
      else
        flash[:danger] = @badge.errors_as_sentence
        render :new
      end
    end

    def update
      @badge = Badge.find(params[:id])

      if @badge.update(badge_params)
        flash[:success] = I18n.t("admin.badges_controller.updated")
        redirect_to admin_badges_path
      else
        flash[:danger] = @badge.errors_as_sentence
        render :edit
      end
    end

    private

    def badge_params
      params.require(:badge).permit(:title, :description, :badge_image, :credits_awarded, :allow_multiple_awards)
    end
  end
end
