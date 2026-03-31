-- 🔊 piper-phonemize xmake build
-- Phonemization glue library for Piper TTS

-- Pull in espeak-ng (provides espeak-ng, ucd, speechPlayer targets)
includes("/Users/mrowr/Code/espeak-ng/espeak-ng/xmake.lua")

-- onnxruntime from xmake package repo (needed for tashkeel Arabic diacritization)
add_requires("onnxruntime")

-- Piper includes these headers as <piper-phonemize/phonemize.hpp>.
-- A symlink build/include/piper-phonemize -> src/ provides that prefix.
local include_root = path.join(os.scriptdir(), "build", "include")

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

    -- "src" for direct includes, "build/include" for <piper-phonemize/...> prefix
    add_includedirs("src", { public = true })
    add_includedirs(include_root, { public = true })

    add_deps("espeak-ng")
    add_packages("onnxruntime", { public = true })

    -- Ensure the piper-phonemize include symlink exists
    before_build(function (target)
        local link = path.join(include_root, "piper-phonemize")
        if not os.isdir(link) then
            os.mkdir(include_root)
            os.run("ln -sf \"%s\" \"%s\"", path.join(os.scriptdir(), "src"), link)
        end
    end)
target_end()
