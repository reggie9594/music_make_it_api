class SalesController < ApplicationController
    # Create an sales order record in database
    def create
      @sales = Sale.create(sales_params);
      if @sales.valid?
        render :status=>201, json:  @sales
      else
        render :status=>500, json: {
                 error: 'Failed to create a salesOders',
               }
      end
    end
  
    # Retriev all sales orders from the database
    def sales
      @sales =Sale.all;
      render :status =>200, json: @sales;
    end
  
    private
    # Returns a copy of the parameters object, returning only the permitted keys and valuesReceives of data send from the client
    def sales_params
      params.require(:sales).permit(:product_id, :customer_id, :price, :quantity, :price, :dilievery_address, :payment_method);
    end
end
