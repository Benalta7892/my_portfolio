class TechnologyItemsController < ApplicationController
  def new
    @technology_item = TechnologyItem.new
  end

  def create
    @technology_item = TechnologyItem.new(technology_item_params)

    if @technology_item.save
      redirect_to root_path, notice: "Nouvelle technologie ajoutée avec succès."
    else
      render :new, alert: "Erreur lors de l'ajout de la technologie."
    end
  end

  def edit
    @technology_item = TechnologyItem.find(params[:id])
  end

  def update
    @technology_item = TechnologyItem.find(params[:id])

    if @technology_item.update(technology_item_params)
      redirect_to root_path, notice: "Technologie modifiée avec succès."
    else
      render :edit, alert: "Erreur lors de la modification de la technologie."
    end
  end

  def destroy
    @technology_item = TechnologyItem.find(params[:id])

    if @technology_item.destroy
      redirect_to root_path, notice: "Technologie supprimée avec succès."
    else
      redirect_to root_path, alert: "Erreur lors de la suppression de la technologie."
    end
  end

  private

  def technology_item_params
    params.require(:technology_item).permit(:name, :link, :logo, :category, :order_position)
  end
end
