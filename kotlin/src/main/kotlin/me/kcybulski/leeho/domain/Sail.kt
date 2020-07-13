package me.kcybulski.leeho.domain

sealed class Sail(val name: String)

class JibSail: Sail("fok")
class MainsailSail: Sail("grot")
class MizzenSail: Sail("bezan")
