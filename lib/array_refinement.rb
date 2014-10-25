module ArrayRefinement

  refine Array do

    def name_sortable
      family = self.last
      given = (size > 1) ? self.first : nil
      mid = (!(family.nil? || family.to_s.empty?) && !(given.nil? || given.to_s.empty?)) ? ', ' : ''
      family.to_s + mid + given.to_s
    end

    def personal_data
      {name: first['lis_person_name_full'], sortable_name: last,
       primary_email: first['lis_person_contact_email_primary']
      }
    end

    def image_hash
      map(&:serializable_hash).each{ |image, image_id|
        image['id'] = "#{image['assignment_id']}-#{image['id']}"
        image['type'] = 'image'
        image['date'] = Date.strptime(image['date'], '%m/%d/%Y').strftime('%Q').to_i
      }
    end

    def video_hash
      map{|media_url|
        {
            media_url.site_tag.to_sym => media_url.site_id,
            canvas_user_id: media_url.canvas_user_id,
            assignment_id: media_url.canvas_assignment_id,
            author: media_url.author,
            id: "#{media_url.canvas_assignment_id}-#{media_url.id}",
            type: 'video',
            image_url: Video::Metadata.thumbnail_url(media_url.site_tag, media_url.site_id),
            date: media_url.created_at.to_i * 1000
        }
      }

    end

  end

end
