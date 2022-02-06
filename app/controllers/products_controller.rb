class ProductsController < ApplicationController
  # Create a product record in database
  def create
    @product = Product.create(product_params);
    if @product.valid?
      render :status=>201, json:  @product
    else
      render :status=>500, json: {
               error: 'Failed to create a product',
             }
    end
  end

  # Retriev all products from the database
  def products
    @products =Product.all;
    render :status =>200, json: @products;
  end

  private
  # Returns a copy of the parameters object, returning only the permitted keys and valuesReceives of data send from the client
  def product_params
    params.require(:product).permit(:name, :description, :created_by, :quantity, :price, :category_id);
  end
end
