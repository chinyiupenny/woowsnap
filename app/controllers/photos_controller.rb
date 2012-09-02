class PhotosController < ApplicationController
  before_filter :load_product
  # GET /photos
  # GET /photos.json
  def index
    @photos = @product.photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = @product.photos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = @product.photos.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = @product.photos.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @product.photos.new(params[:photo])

    if @photo.save
      respond_to do |format|
        format.html {redirect_to product_photos_path(@product), notice: 'Photo was successfully created.'}
        @photos = [@photo]
        format.json {render 'index'}
      end
    else
      render 'new'
    end

    # respond_to do |format|
    #   if @photo.save
    #     format.html { redirect_to @product, notice: 'Photo was successfully created.' }
    #     format.json { render json: @photo, status: :created, location: product_photo_url(@product, @photo)}
    #     # format.json {status: :created}
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @photo.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = @product.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @product, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = @product.photos.find(params[:id])
    AWS::S3::S3Object.delete photo.filename, 'woowsnap_bucket'
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to @product }
      format.json { head :no_content }
    end
  end
  
  private 
  def load_product
    @product = Product.find(params[:product_id])
  end
end
