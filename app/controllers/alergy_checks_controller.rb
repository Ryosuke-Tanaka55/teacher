class AlergyChecksController < ApplicationController
  before_action :set_classroom, only: [:show, :today_index, :one_month_index]

  def show
    @alergy_check_sum = @classroom.alergy_checks.today.count
    @submitted = @classroom.alergy_checks.today.where.not(status: "").count #報告済み件数
  end

  def today_index
    @alergy_checks = @classroom.alergy_checks.today.order(:student_id)
    @teachers = Teacher.all ## 自クラス申請の場合は担任の名前のみ、管理職以外の代理申請の場合は管理職名以外の名前から選択可にする
  end

  def update
    @alergy_check = AlergyCheck.find(params[:alergy_check][:alergy_check_id])
    # 同じschool_idを持つ児童しか選択できない
    if current_teacher.school.id != @alergy_check.student.school_id
      flash[:danger] = "許可されていない操作が行われました。"
      return redirect_to teachers_alergy_checks_url
    end

    #バリデーションチェック前の値セット
    @alergy_check.assign_attributes(today_check_params)

    if @alergy_check.valid?(:today_check) && @alergy_check.save
      flash[:success] = "#{@alergy_check.student.student_name}のチェックを報告しました。"
    else
      flash[:danger] = "#{@alergy_check.student.student_name}のチェック報告に失敗しました。<br>" + "・" + @alergy_check.errors.full_messages.join("<br>・")
    end
    redirect_to teachers_alergy_checks_url
  end

  def one_month_index
    @days_of_the_week = %w{日 月 火 水 木 金 土}
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    @alergy_checks = @classroom.alergy_checks.where(worked_on: @first_day..@last_day).order(:worked_on)
  end

  private
    def set_classroom
      @classroom = current_teacher.classroom
    end

    def today_check_params
      params.require(:alergy_check).permit(:first_check, :second_check, :student_check, :applicant).merge(status: "報告中")
    end
end
