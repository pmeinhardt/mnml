# Configure i18n behaviour while testing.

# Reset locale after each scenario:
After do |scenario|
  I18n.locale = I18n.default_locale
end
