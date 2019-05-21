namespace :update_registries do
# tache à lancer uniquement pour le mariage pilote d'Odile et Paul, email "polodile.mdb@gmail.com"
# merci Kevin !

  desc "on veut mettre à jour le score pour chaque invitation"
  task score_registry: :environment do
    wedding = Wedding.where(email: "polodile.mdb@gmail.com").last
    if wedding
      wedding.registries.find_each do |reg|
        reg.update_score!
      end
    end
  end
end
