class TraceforumImportsController < ApplicationController
  def new
    @data_import = Importers::TraceforumImport.new
  end

  def create
    @data_import = Importers::TraceforumImport.new(data_import_params)
    if @data_import.save
      redirect_to madmin_forums_path, notice: "Les données ont ete importées avec succées"
    else
      redirect_to madmin_forums_path, alert: t('.alert') + @data_import.errors.full_messages.join(', ')
    end
  end

  private

  def data_import_params
    params.require(:data_import).permit(:file)
  end
end