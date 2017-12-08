class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :log_impression, :only=> [:show]
  # 권한설정
  load_and_authorize_resource
  # 로그인 된 사용자만 접근 가능
  before_action :authenticate_user!
  
  def log_impression
      @hit_post = Post.find(params[:id])
      # this assumes you have a current_user method in your authentication system
      @hit_post.impressions.create(ip_address: request.remote_ip)
   end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts = Post.order("created_at DESC").page params[:page]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.page params[:page]
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_name = current_user.nickname

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '게시물이 작성 되었습니다.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '게시물이 수정 되었습니다.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '게시물을 삭제했습니다.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params[:post][:user_id] = current_user.id
      params.require(:post).permit(:title, :content, :user_id) 
    end
end
