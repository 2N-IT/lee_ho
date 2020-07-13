package me.kcybulski.leeho.domain

sealed class Sheet(sail: Sail, prefix: String = "") {

    val name = "$prefix ${sail.name}a szot"

    fun haul(): Nothing = TODO()
    fun pull(): Nothing = TODO()
    fun loosen(): Nothing = TODO()
    fun release(): Nothing = TODO()

}

class LeftJibSheet(sail: JibSail): Sheet(sail, "lewy")
class RightJibSheet(sail: JibSail): Sheet(sail, "prawy")
class MainsailSheet(sail: MainsailSail): Sheet(sail)
class MizzenSheet(sail: MizzenSail): Sheet(sail)
