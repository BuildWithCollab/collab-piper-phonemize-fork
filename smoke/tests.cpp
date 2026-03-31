#include <catch2/catch_test_macros.hpp>

#include <piper-phonemize/phoneme_ids.hpp>

#include <vector>

TEST_CASE("smoke: DEFAULT_PHONEME_ID_MAP is populated", "[smoke]") {
    auto& idMap = piper::DEFAULT_PHONEME_ID_MAP;
    CHECK(idMap.size() > 100);
}
