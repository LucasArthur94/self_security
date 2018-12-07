class DevicesController < ApplicationController
  protect_from_forgery with: :null_session, prepend: true
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # Este método faz uma busca bulk e verifica se a lista de dispositivos passada
  # está no sistema e é válida. Caso pelo menos 1 dispositivo esteja autorizado,
  # a lista é aprovada (Status 200). Se não houver, ela é reprovada (Status 401).

  # POST /verify
  # POST /verify.json
  def verify
    old_devices = Device.where(bluetooth_id: bulk_params[:bluetooth_ids])

    bulk_authorization = old_devices.reduce do |old_device, authorized|
      if old_device && old_device.person
        authorized = authorized || true
      else
        authorized = authorized || false
      end
    end

    if bulk_authorization
      respond_to do |format|
        format.json { render json: { message: 'Dispositivos autorizados!' }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Dispositivos não autorizados!' }, status: :unauthorized }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:bluetooth_id, :person_id)
    end

    def bulk_params
      params.require(:device).permit(bluetooth_ids: [])
    end
end
