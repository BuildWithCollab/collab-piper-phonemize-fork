-- 🔊 piper-phonemize xmake build
-- Phonemization glue library for Piper TTS

add_repositories("BuildWithCollab https://github.com/BuildWithCollab/Packages.git")

add_requires("espeak-ng")
add_requires("onnxruntime")

----------------------------------------------------------------------
-- 📦 piper_phonemize — phonemization library
----------------------------------------------------------------------
target("piper_phonemize")
    set_kind("static")
    set_languages("cxx17")

    add_files(
        "src/phonemize.cpp",
        "src/phoneme_ids.cpp",
        "src/tashkeel.cpp",
        "src/shared.cpp"
    )

    add_includedirs("src", { public = true })

    add_packages("espeak-ng", { public = true })
    add_packages("onnxruntime", { public = true })

    -- Install headers under piper-phonemize/ prefix so consumers
    -- can #include <piper-phonemize/phonemize.hpp>
    add_headerfiles("src/*.hpp", "src/*.h", { prefixdir = "piper-phonemize" })
target_end()
