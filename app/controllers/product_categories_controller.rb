class ProductCategoriesController < ApplicationController
      # Create an product_categories order record in database
      def create
        @product_categories = Sale.create(product_categories_params);
        if @product_categories.valid?
          render :status=>201, json:  @product_categories
        else
          render :status=>500, json: {
                   error: 'Failed to create a product_categories',
                 }
        end
      end
    
      # Retriev all product_categories orders from the database
      def product_categories
        @product_categories =Sale.all;
        render :status =>200, json: @product_categories;
      end
    
      private
      # Returns a copy of the parameters object, returning only the permitted keys and valuesReceives of data send from the client
      def product_categories_params
        params.require(:product_categories).permit(:name, :description);
      end
end
