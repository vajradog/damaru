class GeneralSetting < ActiveRecord::Base
  validates_presence_of :title, :header, :subheader
end
