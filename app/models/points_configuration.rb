class PointsConfiguration < ActiveRecord::Base

  @@config_mapping = nil

  def self.update(points_configuration_json)
    points_configuration_json.each do |activity_points| #each line is an activity mapping to point allowance
      activity_mapping = PointsConfiguration.find_or_initialize_by(interaction: activity_points[:name])
      activity_mapping.pcid = activity_points[:id]
      activity_mapping.points_associated = activity_points[:points]
      activity_mapping.save
    end
  end

  def self.recache_mappings!
    @@config_mapping = self.select(:points_associated, :interaction).inject({}){|memo, pc| memo.merge!( {pc[:interaction] => pc[:points_associated]})}
  end

  def self.cached_mappings
    @@config_mapping || self.recache_mappings!
  end

end
