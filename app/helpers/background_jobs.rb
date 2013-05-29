def job_status(jid)
  waiting = Sidekiq::Queue.new
  working = Sidekiq::Workers.new
  pending = Sidekiq::ScheduledSet.new
  return 'pending' if pending.find { |job| job.jid == jid }
  return 'waiting' if waiting.find { |job| job.jid == jid }
  return 'scheduled' if working.find { |worker, info| info["payload"]["jid"] == jid }
  'complete'
end
