class Goal < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validate :start_date_check

  def status
    if end_date.present?
      '完了'
    elsif interrupted
      '中断中'
    elsif start_date > Date.today
      '開始前'
    else
      '進行中'
    end
  end

  private

  def start_date_check
    validate_date_order(:schedules_end_date)
    validate_date_order(:end_date)
  end

  def validate_date_order(target_date)
    if send(target_date).present? && start_date > send(target_date)
      errors.add(target_date, :start_date_invalid)
    end
  end
end
