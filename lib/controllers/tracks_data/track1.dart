import '../../models/track.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

final track1 = Track(
  id: mongo.ObjectId(),
  name: 'Route 4 Morning',
  isAssigned: false,
  stops: [
    Stop(
        id: mongo.ObjectId(),
        name: "Muslim Town Mor",
        time: const TimeOfDay(hour: 14, minute: 50),
        isStop: true,
        stopNo: 1,
        latitude: 31.520224,
        longitude: 74.32548),
    Stop(
        id: mongo.ObjectId(),
        name: "Muslim Town Mor",
        time: const TimeOfDay(hour: 6, minute: 50),
        isStop: true,
        stopNo: 2,
        latitude: 31.520224,
        longitude: 74.32548),
    Stop(
        id: mongo.ObjectId(),
        name: "Naqsha Stop",
        time: const TimeOfDay(hour: 06, minute: 51),
        isStop: true,
        stopNo: 3,
        latitude: 31.516496515862194,
        longitude: 74.31495641365117),
    Stop(
        id: mongo.ObjectId(),
        name: "",
        time: const TimeOfDay(hour: 6, minute: 52),
        isStop: true,
        stopNo: 4,
        latitude: 31.514566547816308,
        longitude: 74.31116610208386),
    Stop(
        id: mongo.ObjectId(),
        name: "",
        time: const TimeOfDay(hour: 06, minute: 53),
        isStop: true,
        stopNo: 5,
        latitude: 31.51180641575131,
        longitude: 74.30546749588095),
    Stop(
        id: mongo.ObjectId(),
        name: "Bhekewal Morr",
        time: const TimeOfDay(hour: 06, minute: 54),
        isStop: true,
        stopNo: 6,
        latitude: 31.509720108000938,
        longitude: 74.30095038651243),
    Stop(
        id: mongo.ObjectId(),
        name: "Kareem Block Stop",
        time: const TimeOfDay(hour: 06, minute: 58),
        isStop: true,
        stopNo: 7,
        latitude: 31.50122998890972,
        longitude: 74.28026748058),
    Stop(
        id: mongo.ObjectId(),
        name: "Mustafa Town",
        time: const TimeOfDay(hour: 06, minute: 59),
        isStop: true,
        stopNo: 8,
        latitude: 31.49883465696848,
        longitude: 74.2737166033416),
    Stop(
        id: mongo.ObjectId(),
        name: "Awan Town ",
        time: const TimeOfDay(hour: 07, minute: 03),
        isStop: true,
        stopNo: 9,
        latitude: 31.5033718079466,
        longitude: 74.26793484752756),
    Stop(
        id: mongo.ObjectId(),
        name: "Kharak Stop",
        time: const TimeOfDay(hour: 07, minute: 05),
        isStop: true,
        stopNo: 10,
        latitude: 31.50966603509507,
        longitude: 74.27212475774462),
    Stop(
        id: mongo.ObjectId(),
        name: "PSO Petrol Pump",
        time: const TimeOfDay(hour: 07, minute: 07),
        isStop: true,
        stopNo: 11,
        latitude: 31.51543738600657,
        longitude: 74.27591024302575),
    Stop(
        id: mongo.ObjectId(),
        name: "Liaqat Chowk",
        time: const TimeOfDay(hour: 07, minute: 09),
        isStop: true,
        stopNo: 12,
        latitude: 31.521692515968407,
        longitude: 74.26946774070564),
    Stop(
        id: mongo.ObjectId(),
        name: "Main Blvd Sabzazar",
        time: const TimeOfDay(hour: 07, minute: 11),
        isStop: true,
        stopNo: 13,
        latitude: 31.5285325061472,
        longitude: 74.26523624077748),
    Stop(
        id: mongo.ObjectId(),
        name: "Main Blvd Sabzazar",
        time: const TimeOfDay(hour: 7, minute: 02),
        isStop: true,
        stopNo: 14,
        latitude: 31.53210087649549,
        longitude: 74.26298476776134),
    Stop(
        id: mongo.ObjectId(),
        name: "Babu Sahbu Bus Stop",
        time: const TimeOfDay(hour: 07, minute: 14),
        isStop: true,
        stopNo: 15,
        latitude: 31.53773562286785,
        longitude: 74.26707144906402),
    Stop(
        id: mongo.ObjectId(),
        name: "Uet-Ksk",
        time: const TimeOfDay(hour: 07, minute: 49),
        isStop: true,
        stopNo: 16,
        latitude: 31.692504,
        longitude: 74.252004),
  ],
  path: [
    [74.32548, 31.520224],
    [74.325385, 31.520302],
    [74.325029, 31.520685],
    [74.324665, 31.520577],
    [74.324594, 31.520556],
    [74.324289, 31.520461],
    [74.323979, 31.520393],
    [74.323652, 31.52032],
    [74.323349, 31.520288],
    [74.322716, 31.520228],
    [74.322178, 31.520192],
    [74.321714, 31.520152],
    [74.321347, 31.52005],
    [74.321151, 31.519988],
    [74.320652, 31.519782],
    [74.320419, 31.519663],
    [74.32018, 31.519514],
    [74.319735, 31.519169],
    [74.31914, 31.518649],
    [74.318944, 31.518481],
    [74.318599, 31.518188],
    [74.318225, 31.518],
    [74.315238, 31.516588],
    [74.314854, 31.516404],
    [74.313756, 31.515871],
    [74.313396, 31.515701],
    [74.313261, 31.515637],
    [74.312254, 31.515125],
    [74.311629, 31.514829],
    [74.311048, 31.514523],
    [74.309697, 31.513879],
    [74.308243, 31.513194],
    [74.307672, 31.512907],
    [74.306617, 31.512389],
    [74.305801, 31.511988],
    [74.304851, 31.511521],
    [74.304441, 31.511329],
    [74.303516, 31.510876],
    [74.303222, 31.510737],
    [74.301493, 31.509919],
    [74.301354, 31.509852],
    [74.300975, 31.509685],
    [74.299098, 31.508776],
    [74.295657, 31.507109],
    [74.293843, 31.506242],
    [74.293222, 31.50595],
    [74.292338, 31.505566],
    [74.291796, 31.505331],
    [74.290976, 31.504971],
    [74.290093, 31.50462],
    [74.28989, 31.504555],
    [74.287771, 31.503834],
    [74.28621, 31.503305],
    [74.285992, 31.503231],
    [74.285069, 31.502892],
    [74.283438, 31.502326],
    [74.282646, 31.502056],
    [74.282422, 31.501986],
    [74.281887, 31.501795],
    [74.28105, 31.501485],
    [74.280279, 31.501199],
    [74.279863, 31.501044],
    [74.278225, 31.50051],
    [74.276767, 31.499982],
    [74.276466, 31.499868],
    [74.275613, 31.499545],
    [74.274144, 31.498989],
    [74.274048, 31.498953],
    [74.27387, 31.498885],
    [74.27245, 31.498357],
    [74.271986, 31.49818],
    [74.271302, 31.497943],
    [74.271211, 31.497913],
    [74.270766, 31.497767],
    [74.269816, 31.497474],
    [74.269585, 31.49741],
    [74.269422, 31.497365],
    [74.269409, 31.497361],
    [74.268843, 31.497204],
    [74.26831, 31.497053],
    [74.268077, 31.496995],
    [74.266099, 31.496435],
    [74.264752, 31.496085],
    [74.264414, 31.496069],
    [74.264233, 31.4961],
    [74.264083, 31.496147],
    [74.263958, 31.496188],
    [74.264001, 31.496277],
    [74.264042, 31.496359],
    [74.264248, 31.496765],
    [74.264714, 31.497693],
    [74.264951, 31.498165],
    [74.265009, 31.498279],
    [74.265505, 31.499188],
    [74.265733, 31.499632],
    [74.266571, 31.50125],
    [74.266704, 31.501456],
    [74.267347, 31.502445],
    [74.267581, 31.502806],
    [74.267807, 31.503152],
    [74.268459, 31.504151],
    [74.269391, 31.50558],
    [74.27017, 31.506752],
    [74.270594, 31.507364],
    [74.271618, 31.50887],
    [74.271878, 31.509233],
    [74.271951, 31.509334],
    [74.272345, 31.509874],
    [74.272769, 31.510499],
    [74.272943, 31.510755],
    [74.274197, 31.512667],
    [74.274445, 31.513045],
    [74.274821, 31.513619],
    [74.275392, 31.514491],
    [74.275431, 31.51455],
    [74.275573, 31.514751],
    [74.275677, 31.514898],
    [74.275836, 31.515122],
    [74.275902, 31.515216],
    [74.275942, 31.515372],
    [74.275918, 31.515493],
    [74.275863, 31.515608],
    [74.274985, 31.515988],
    [74.273732, 31.516734],
    [74.272897, 31.517232],
    [74.272578, 31.517422],
    [74.272066, 31.517775],
    [74.271981, 31.517834],
    [74.27133, 31.518824],
    [74.271229, 31.518981],
    [74.270867, 31.519541],
    [74.270735, 31.519751],
    [74.270071, 31.520811],
    [74.270071, 31.520811],
    [74.269992, 31.520936],
    [74.269115, 31.522327],
    [74.268774, 31.522865],
    [74.268209, 31.523755],
    [74.267141, 31.525438],
    [74.265852, 31.527494],
    [74.265229, 31.528487],
    [74.262947, 31.532088],
    [74.26239, 31.532979],
    [74.262334, 31.533226],
    [74.262341, 31.533292],
    [74.262374, 31.533369],
    [74.26342, 31.535024],
    [74.263398, 31.535071],
    [74.263391, 31.535121],
    [74.263398, 31.535161],
    [74.263424, 31.53522],
    [74.263487, 31.53526],
    [74.263534, 31.535274],
    [74.263605, 31.535288],
    [74.263674, 31.535298],
    [74.263743, 31.535291],
    [74.263818, 31.535275],
    [74.263987, 31.535263],
    [74.264113, 31.535277],
    [74.264273, 31.535319],
    [74.264311, 31.535329],
    [74.264369, 31.535345],
    [74.264605, 31.535442],
    [74.265031, 31.535642],
    [74.265432, 31.535831],
    [74.266098, 31.53609],
    [74.266242, 31.536146],
    [74.266593, 31.536262],
    [74.266717, 31.536303],
    [74.267068, 31.536453],
    [74.267148, 31.536508],
    [74.267185, 31.536579],
    [74.267201, 31.536645],
    [74.267201, 31.536766],
    [74.267136, 31.537517],
    [74.267085, 31.537939],
    [74.267059, 31.53816],
    [74.267077, 31.53826],
    [74.266424, 31.538437],
    [74.265786, 31.53867],
    [74.265495, 31.538754],
    [74.265144, 31.538833],
    [74.264854, 31.53888],
    [74.264805, 31.539008],
    [74.264801, 31.539103],
    [74.26481, 31.53916],
    [74.264939, 31.539485],
    [74.265016, 31.539627],
    [74.26513, 31.539892],
    [74.265345, 31.540386],
    [74.265441, 31.540602],
    [74.265552, 31.540853],
    [74.265666, 31.541178],
    [74.266332, 31.543267],
    [74.266419, 31.543517],
    [74.266656, 31.544195],
    [74.266883, 31.544842],
    [74.267757, 31.547641],
    [74.267907, 31.548155],
    [74.268035, 31.548511],
    [74.268143, 31.548723],
    [74.268297, 31.548918],
    [74.270463, 31.551227],
    [74.270571, 31.551345],
    [74.272559, 31.553521],
    [74.273218, 31.554255],
    [74.273817, 31.554921],
    [74.274096, 31.555204],
    [74.274192, 31.555325],
    [74.274208, 31.555358],
    [74.274304, 31.555473],
    [74.274438, 31.555672],
    [74.27459, 31.555857],
    [74.275182, 31.556503],
    [74.27596, 31.557473],
    [74.276564, 31.558168],
    [74.276896, 31.558549],
    [74.277501, 31.559528],
    [74.27776, 31.560031],
    [74.279612, 31.563329],
    [74.280145, 31.564279],
    [74.28091, 31.565682],
    [74.282345, 31.568313],
    [74.282485, 31.568595],
    [74.283194, 31.569869],
    [74.283701, 31.570825],
    [74.284266, 31.571872],
    [74.284438, 31.572198],
    [74.284507, 31.572335],
    [74.284659, 31.572572],
    [74.285781, 31.574636],
    [74.287103, 31.576953],
    [74.28742, 31.577527],
    [74.288414, 31.579327],
    [74.289248, 31.580812],
    [74.29008, 31.58236],
    [74.29094, 31.583963],
    [74.29151, 31.585176],
    [74.29168, 31.58561],
    [74.291821, 31.585992],
    [74.292724, 31.588636],
    [74.294079, 31.592385],
    [74.294185, 31.592663],
    [74.294762, 31.594294],
    [74.295368, 31.595972],
    [74.296125, 31.598162],
    [74.296571, 31.599431],
    [74.296815, 31.600161],
    [74.297088, 31.600893],
    [74.297339, 31.601641],
    [74.29756, 31.602304],
    [74.29773, 31.603057],
    [74.297703, 31.603356],
    [74.297599, 31.603632],
    [74.297414, 31.603877],
    [74.297239, 31.604042],
    [74.297, 31.604268],
    [74.296922, 31.60437],
    [74.296875, 31.60448],
    [74.29683, 31.604646],
    [74.29682, 31.604779],
    [74.296851, 31.604917],
    [74.29689, 31.605023],
    [74.296933, 31.605117],
    [74.297014, 31.605218],
    [74.297101, 31.6053],
    [74.297217, 31.605388],
    [74.29732, 31.605466],
    [74.297403, 31.605546],
    [74.297487, 31.605648],
    [74.297536, 31.605757],
    [74.297577, 31.605877],
    [74.29759, 31.605998],
    [74.297574, 31.606085],
    [74.297553, 31.606156],
    [74.297331, 31.606407],
    [74.294383, 31.610031],
    [74.294127, 31.610332],
    [74.293686, 31.610793],
    [74.293406, 31.611121],
    [74.293337, 31.611199],
    [74.292974, 31.611656],
    [74.292017, 31.612937],
    [74.291364, 31.613821],
    [74.291093, 31.614154],
    [74.29093, 31.614379],
    [74.290834, 31.614595],
    [74.290752, 31.614929],
    [74.290678, 31.615441],
    [74.290601, 31.616013],
    [74.290541, 31.616365],
    [74.290423, 31.616974],
    [74.29038, 31.617233],
    [74.290362, 31.617345],
    [74.290346, 31.617427],
    [74.290276, 31.617878],
    [74.290253, 31.618003],
    [74.29021, 31.618248],
    [74.290165, 31.618455],
    [74.28986, 31.619878],
    [74.288632, 31.625924],
    [74.288287, 31.627621],
    [74.287927, 31.629338],
    [74.286085, 31.638123],
    [74.285957, 31.638734],
    [74.285927, 31.638884],
    [74.285489, 31.640927],
    [74.285488, 31.640932],
    [74.285445, 31.641111],
    [74.285444, 31.641116],
    [74.284673, 31.644689],
    [74.284183, 31.647126],
    [74.284091, 31.647585],
    [74.284034, 31.647866],
    [74.283839, 31.648763],
    [74.283743, 31.649205],
    [74.283627, 31.649768],
    [74.283512, 31.650329],
    [74.283433, 31.650713],
    [74.283329, 31.651221],
    [74.282908, 31.65327],
    [74.282758, 31.653997],
    [74.282613, 31.654696],
    [74.282502, 31.655232],
    [74.282484, 31.655316],
    [74.282049, 31.657388],
    [74.281785, 31.658653],
    [74.281427, 31.660361],
    [74.281371, 31.660629],
    [74.281316, 31.660893],
    [74.281124, 31.661812],
    [74.280297, 31.665765],
    [74.279958, 31.667387],
    [74.279591, 31.669139],
    [74.279537, 31.669396],
    [74.27936, 31.670239],
    [74.278838, 31.672719],
    [74.278083, 31.676309],
    [74.277935, 31.677012],
    [74.277903, 31.677166],
    [74.277806, 31.677627],
    [74.277179, 31.680702],
    [74.276993, 31.681595],
    [74.276876, 31.682087],
    [74.276563, 31.683674],
    [74.276185, 31.685405],
    [74.275506, 31.688561],
    [74.275475, 31.688706],
    [74.275352, 31.689194],
    [74.275254, 31.689763],
    [74.275091, 31.690544],
    [74.275039, 31.690794],
    [74.274982, 31.691065],
    [74.274843, 31.691621],
    [74.274799, 31.691966],
    [74.27463, 31.69273],
    [74.274368, 31.693919],
    [74.273581, 31.697668],
    [74.273326, 31.698884],
    [74.273093, 31.699996],
    [74.273093, 31.699996],
    [74.273043, 31.700128],
    [74.273001, 31.700185],
    [74.27294, 31.700231],
    [74.272876, 31.700254],
    [74.272791, 31.700266],
    [74.272622, 31.700273],
    [74.272444, 31.700269],
    [74.272267, 31.700253],
    [74.271336, 31.700109],
    [74.271288, 31.700092],
    [74.271249, 31.700063],
    [74.271247, 31.700026],
    [74.271237, 31.699969],
    [74.271196, 31.699895],
    [74.271122, 31.699826],
    [74.271031, 31.699777],
    [74.270944, 31.699753],
    [74.270862, 31.699759],
    [74.270809, 31.699782],
    [74.270775, 31.699812],
    [74.270678, 31.699764],
    [74.270655, 31.699731],
    [74.270637, 31.699705],
    [74.270569, 31.699603],
    [74.270518, 31.699481],
    [74.270486, 31.699351],
    [74.270482, 31.699232],
    [74.270549, 31.69858],
    [74.270542, 31.698467],
    [74.2705, 31.698377],
    [74.270414, 31.698282],
    [74.270219, 31.698122],
    [74.270086, 31.698028],
    [74.269178, 31.697635],
    [74.26895, 31.697575],
    [74.268853, 31.697563],
    [74.268742, 31.697473],
    [74.26702, 31.6974],
    [74.266827, 31.697366],
    [74.266653, 31.697284],
    [74.265515, 31.69656],
    [74.265183, 31.696435],
    [74.263726, 31.696003],
    [74.261798, 31.695433],
    [74.257619, 31.694155],
    [74.257131, 31.694013],
    [74.257023, 31.693981],
    [74.252165, 31.692546],
    [74.252004, 31.692504]
  ],
);
