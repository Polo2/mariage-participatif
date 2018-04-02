namespace :update_registries do
  desc 'on veut mettre à jour le score pour chaque invitation '

# tache à lancer uniquement pour le mariage pilote d'Odile et Paul, numéro id 23

  task score_registry: :environment do
    wedding = Wedding.find(23)
    registries = wedding.registries
    registries.each do |reg|
      reg.score_registry = reg.update_score
      reg.save
    end

  end

# merci Kevin !

end
