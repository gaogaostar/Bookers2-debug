class SearchesController < ApplicationController
  def search
    # viewのform_withにて選択したmodelを@modelに代入（UserかBookか）
    @model = params["model"]
    # 選択した検索方法を@methodに代入（完全一致, 前方一致, 後方一致, 部分一致）
    @method = params["method"]
    # 検索ワードを@contentに代入
    @content = params["content"]
    # （@model, @method, @content）を代入したsearch_forを@recordsに代入
    @records = search_for(@model, @method, @content)
  end

  private
  def search_for(model, method, content)
    # 選択したモデルがuserだったら
    if model == 'user'
      # 選択した検索方法が完全一致だったら
      if method == 'perfect_match'
        User.where(name:content)
      # 前方一致なら
      elsif method == 'forward_match'
        User.where('name LIKE ?', content+'%')
      # 後方一致なら
      elsif method == 'backward_match'
        User.where('name LIKE ?', '%'+content)
      # 部分一致なら
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
      # 選択したモデルがbookだったら
    elsif model == 'book'
      # 完全一致なら
      if method == 'perfect_match'
        Book.where(title:content)
      # 前方一致なら
      elsif method == 'forward_match'
        Book.where('title LIKE ?', content+'%')
      # 後方一致なら
      elsif
        Book.where('title LIKE ?', '%'+content)
      # 部分一致なら
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
