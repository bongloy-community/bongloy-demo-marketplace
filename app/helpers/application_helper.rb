module ApplicationHelper
  DEFAULT_ALERT_CLASSES = {
    success: "alert-success",
    error: "alert-danger",
    alert: "alert-warning",
    notice: "alert-info"
  }.freeze

  def flash_type_class(flash_type)
    DEFAULT_ALERT_CLASSES[flash_type.to_sym] || flash_type.to_s
  end
end
