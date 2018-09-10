module Filter
  extend ActiveSupport::Concern
  class_methods do	
    def filter params
      films = self.all
      if params[:search_params].present?
        films = self.search_in_cat params[:search_params]
      end
  
      if params[:sort_params].present?
        films = self.sort_films params[:sort_params]
      end

      if params[:year_params].present?
        films = self.filter_by_year params[:year_params]
      end

      if params[:director_params].present?
        films = self.filter_by_director params[:director_params]
      end

      if params[:start_date].present? && params[:end_date].present?
        films = self.filter_by_interval params[:start_date],
          params[:end_date]
      end
      films
    end
  end
end
