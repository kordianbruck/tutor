class AnalysesController < ApplicationController
	before_action :authenticate_user!
	before_action :admincheck, except: [:show, :index]
	before_action :set_analysis, only: [:show, :edit, :update, :destroy]

	# GET /analyses
	# GET /analyses.json
	def index
		@analyses = Analysis.all
		@analyses = @analyses.where(:admin => false) if current_user.nil? or (current_user.role != "admin" and current_user.role != "analyst")
		@analyses = @analyses.order(:exam)
	end

	# GET /analyses/1
	# GET /analyses/1.json
	def show
		admincheck() if @analysis.admin
	end

	def execute
		a = Analysis.where(:id => params["id"]).first
		a = Analysis.new if not a.present?
		@exam = Exam.first
		a.query=params["query"]
		a.view=params["view"]
		render :partial => "analysis", :locals => { :a => a }, :layout => false
	end

	# GET /analyses/new
	def new
		@analysis = Analysis.new(exam: @exam.present?)
	end

	# GET /analyses/1/edit
	def edit
	end

	# POST /analyses
	# POST /analyses.json
	def create
		@analysis = Analysis.new(analysis_params)

		respond_to do |format|
			if @analysis.save
				format.html { redirect_to @analysis, notice: 'Analysis was successfully created.' }
				format.json { render action: 'show', status: :created, location: @analysis }
			else
				format.html { render action: 'new' }
				format.json { render json: @analysis.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /analyses/1
	# PATCH/PUT /analyses/1.json
	def update
		respond_to do |format|
			if @analysis.update(analysis_params)
				format.html { redirect_to @analysis, notice: 'Analysis was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @analysis.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /analyses/1
	# DELETE /analyses/1.json
	def destroy
		@analysis.destroy
		respond_to do |format|
			format.html { redirect_to analyses_url }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_analysis
			@analysis = Analysis.find(params[:id])
			@exam = params[:exam_id] ? Analysis.find(params[:exam_id]) : Exam.first
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def analysis_params
			params.require(:analysis).permit(:name, :query, :admin, :view, :exam)
		end
end
