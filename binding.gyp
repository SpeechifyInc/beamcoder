{
  "targets": [{
    "target_name" : "beamcoder",
    "sources" : [ "src/beamcoder.cc", "src/beamcoder_util.cc",
                  "src/governor.cc", "src/demux.cc",
                  "src/decode.cc", "src/filter.cc",
                  "src/encode.cc", "src/mux.cc",
                  "src/packet.cc", "src/frame.cc",
                  "src/codec_par.cc", "src/format.cc",
                  "src/codec.cc", "src/hwcontext.cc" ],
    "conditions": [
      ['OS!="win"', {
        "defines": [
          "__STDC_CONSTANT_MACROS"
        ],
        "cflags_cc!": [
          "-fno-rtti",
          "-fno-exceptions"
        ],
        "cflags_cc": [
          "-std=c++11",
          "-fexceptions"
        ],
        "link_settings": {
          "libraries": [
            "<(module_root_dir)/ffmpeg/build/lib/libavcodec.so",
            "<(module_root_dir)/ffmpeg/build/lib/libavdevice.so",
            "<(module_root_dir)/ffmpeg/build/lib/libavfilter.so",
            "<(module_root_dir)/ffmpeg/build/lib/libavformat.so",
            "<(module_root_dir)/ffmpeg/build/lib/libavutil.so",
            "<(module_root_dir)/ffmpeg/build/lib/libpostproc.so",
            "<(module_root_dir)/ffmpeg/build/lib/libswresample.so",
            "<(module_root_dir)/ffmpeg/build/lib/libswscale.so"
          ]
        }
      }]
  ]
}]
}
