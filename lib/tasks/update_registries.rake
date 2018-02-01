namespace :update_registries do
  desc 'on veut mettre à jour le score pour chaque invitation '

  task score_registry: :environment do
    wedding = Wedding.find(8)
    registries = wedding.registries
    registries.each do |reg|
      reg.score_registry = reg.update_score
      reg.save
    end

  end


end
