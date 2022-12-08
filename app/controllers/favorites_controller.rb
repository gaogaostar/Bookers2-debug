class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    # 非同期通信にするため削除 redirect_back(fallback_location: root_path)
    # redirectを削除したので、app/views/favorites/create.js.erbを探しに行く
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorire = @book.favorites.find_by(user_id: current_user.id)
    favorire.destroy
    # 削除 redirect_back(fallback_location: root_path)
  end
end
