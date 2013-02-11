require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'rho/rhotabbar'

class NewsController < Rho::RhoController
  include BrowserHelper

  Rho::NativeTabbar.create(:tabs => @tabs,:place_tabs_bottom => true)
  # GET /News
  def index
    @news = News.find(:all)
    render :back => '/app'
  end

  # GET /News/{1}
  def show
    @news = News.find(@params['id'])
    if @news
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /News/new
  def new
    @news = News.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /News/{1}/edit
  def edit
    @news = News.find(@params['id'])
    if @news
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /News/create
  def create
    @news = News.create(@params['news'])
    redirect :action => :index
  end

  # POST /News/{1}/update
  def update
    @news = News.find(@params['id'])
    @news.update_attributes(@params['news']) if @news
    redirect :action => :index
  end

  # POST /News/{1}/delete
  def delete
    @news = News.find(@params['id'])
    @news.destroy if @news
    redirect :action => :index  
  end

  # Show English News Page
  def en_page
      WebView.navigate('http://techcrunch.com/')
      WebView.execute_js("function test(){ alert('test'); }")
  end

  # Show Japanese News Page
  def jp_page
      WebView.navigate('http://jp.techcrunch.com/')
  end
end
