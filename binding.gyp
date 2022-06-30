{
  "targets": [{
    "target_name": "beamcoder",
    "sources": ["src/beamcoder.cc", "src/beamcoder_util.cc",
                "src/governor.cc", "src/demux.cc",
                "src/decode.cc", "src/filter.cc",
                "src/encode.cc", "src/mux.cc",
                "src/packet.cc", "src/frame.cc",
                "src/codec_par.cc", "src/format.cc",
                "src/codec.cc", "src/hwcontext.cc"],
    "defines": ["__STDC_CONSTANT_MACROS"],
    "cflags_cc!": ["-fno-rtti", "-fno-exceptions"],
    "cflags_cc": [ "-std=c++11", "-fexceptions"]
  }]
}
