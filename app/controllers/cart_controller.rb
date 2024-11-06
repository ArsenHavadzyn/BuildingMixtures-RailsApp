class CartController < ApplicationController
  def show
    @cart_items = CartItem.all
  end

  def add_item
    @post = Post.find(params[:post_id])
    @cart_item = CartItem.new(post: @post, quantity: 1) 
    if @cart_item.save
      if params[:redirect_to_cart]
        redirect_to cart_path, notice: "Товар додано до кошика. Перенаправлення до кошика..."
      else
        redirect_to @post, notice: "Товар додано до кошика!"
      end
    else
      redirect_to @post, alert: "Не вдалося додати товар до кошика."
    end
  end

  def clear_cart
    @cart_items = CartItem.all
    @cart_items.each(&:destroy)
    redirect_to cart_path, notice: "Ваше замовлення оформлене!"
  end
  
  def remove_item
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, alert: "Товар видалено з кошика."
  end

  private

  def item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
