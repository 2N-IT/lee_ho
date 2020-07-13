package me.kcybulski.leeho.domain

import me.kcybulski.leeho.domain.Answer.*

sealed class SheetMan(val sheet: Sheet, name: String) : CrewMan(name) {

    fun haul(): Answer = YO.also { shout("Jest ${sheet.name} wybierz") }

    fun pull(): Answer = YO.also { shout("Jest ${sheet.name} wybieraj") }

    fun release(): Answer = YO.also { shout("Jest ${sheet.name} luz") }

    fun loosen(): Answer = YO.also { shout("Jest ${sheet.name} luzuj") }

}

class LeftJibSheetMan(sheet: LeftJibSheet, name: String) : SheetMan(sheet, name)
class RightJibSheetMan(sheet: RightJibSheet, name: String) : SheetMan(sheet, name)
class MainsailSheetMan(sheet: MainsailSheet, name: String) : SheetMan(sheet, name)
class MizzenSheetMan(sheet: MizzenSheet, name: String) : SheetMan(sheet, name)
