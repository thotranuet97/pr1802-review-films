class ExportFilmsController < ApplicationController
  def index
    @films = Film.order :name
    respond_to do |format|
      format.html
      format.csv {send_data @films.to_csv}
      format.xls {send_data @films.to_csv col_sep: "\t"}
    end
  end
end
