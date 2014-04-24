class ActiveRecordPersistenceBase
  def persist(resource)
    resource.save!
  end
end
