# ÖDEV 1
# bir operatör tanımlanacak(gerçek ya da sanal bir operatör olabilir), 
# bizim belirleyeceğimiz nesneler ile işlem yapacak.

# Bir savaşcı class'ı oluşturuyoruz.
# Savaşçımız isim, can, enerji, güç, ve şans değerlerine sahip olacak.

warrior <- setRefClass(Class = "warrior", fields = c("name", "hitpoint", "energy", "power", "luck"), methods = list(
  initialize = function(name, hitpoint, energy, power, luck){
    .self$name <- name
    .self$hitpoint <- hitpoint
    .self$energy <- energy
    .self$power <- power
    .self$luck <- luck
  },
  
  # Savaşçı özelliklerini göstereceğimiz fonksiyonlar.
  show_name = function(){
    return(name)
  },
  show_hp = function(){
    return(hitpoint)
  },
  show_energy = function(){
    return(energy)
  },
  show_power = function(){
    return(power)
  },
  show_luck = function(){
    return(luck)
  },
  show_damage= function(){
    damage <- energy * power * luck 
    return(damage)
  },
  show = function(){
    cat("Warrior: ", name, "\n",
        "HP:", hitpoint, "|",
        "Energy:", energy, "|",
        "Power:", power, "|",
        "Luck:", luck, "|",
        "Damage:", show_damage() )
  },
  # Savaşçı Karşılaştırma
  warrios_vs = function(warrior_2){
    cat(" Warrior: ", name, "|",
        "HP:", hitpoint, "|",
        "Damage:", show_damage(), "\n",
        "Warrior: ", warrior_2$name,"|",
        "HP:", warrior_2$hitpoint, "|",
        "Damage:", warrior_2$show_damage()
        )
  }
))


# Operatör Tanımlama.

'%+%' <- function(x, ...){
  UseMethod("gucbirlestir", x)
}    
gucbirlestir.warrior <- function(a, b){
  list(
    hitpoint = a$hitpoint + b$hitpoint,
    energy = a$energy + b$energy,
    power = a$power + b$power,
    luck = a$luck + b$luck,
    damage = a$show_damage() + b$show_damage()
  )
}

'%-%' <- function(x, ...){
  UseMethod("dovus", x)
}    
dovus.warrior <- function(a, b){
  list(
    a_hitpoint = a$hitpoint - b$show_damage(),
    b_hitpoint = b$hitpoint - a$show_damage()
  )
}


ahmet <- warrior$new("Ahmet", 100, 25, 8, 0.6)
ali <- warrior$new("Ali", 100, 45, 3, 0.7)
ahmet %+% ali
ahmet %-% ali
