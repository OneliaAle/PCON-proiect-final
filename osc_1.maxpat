{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 335.0, 122.0, 1339.0, 786.0 ],
		"gridsize" : [ 15.0, 15.0 ],
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-22",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 963.0, 656.0, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 3,
					"outlettype" : [ "signal", "signal", "" ],
					"patching_rect" : [ 1052.0, 400.0, 130.0, 22.0 ],
					"text" : "hirt.convolutionreverb~",
					"varname" : "hirt.convolutionreverb~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 737.0, 660.0, 45.0, 22.0 ],
					"text" : "cverb~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 4,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 969.0, 540.0, 81.0, 22.0 ],
					"saved_object_attributes" : 					{
						"active" : [ 1 ],
						"gain" : 1.0,
						"interpolation" : 1,
						"order" : 1,
						"rotate_order" : 0
					}
,
					"text" : "ambidecode~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "signal", "signal", "signal", "signal" ],
					"patching_rect" : [ 854.0, 460.0, 91.0, 22.0 ],
					"saved_object_attributes" : 					{
						"active" : [ 1 ],
						"center_att_db" : 6.0,
						"center_curve" : 0.2,
						"center_size" : 1.0,
						"db_unit" : 1.5,
						"dist_att" : 1.0,
						"exp_curve" : 1.0,
						"exp_cutoff_dist" : 30.0,
						"order" : 1,
						"rotate_order" : 0
					}
,
					"text" : "ambiencode~ 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 549.0, 537.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "gain~",
					"multichannelvariant" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 560.0, 360.0, 21.0, 122.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 259.583325624465942, 504.166647434234619, 50.0, 36.0 ],
					"text" : "0.810329"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"linecount" : 3,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 205.416661024093628, 432.291650176048279, 29.5, 50.0 ],
					"text" : "0.58162"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-60",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 106.45833146572113, 517.708313584327698, 50.0, 36.0 ],
					"text" : "0.225143"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-58",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 795.0, 53.0, 150.0, 48.0 ],
					"text" : "de primit valori laanumite intervale sa nu am schimbari bruste"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-50",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 26.250001192092896, 423.958317160606384, 50.0, 36.0 ],
					"text" : "0.144292"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-46",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 5,
					"outlettype" : [ "", "", "", "", "" ],
					"patching_rect" : [ 57.5, 338.541653752326965, 336.0, 22.0 ],
					"text" : "route /left/distance1 /left/rotation1 /left/distance2 /left/rotation2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-44",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 57.5, 299.999988555908203, 97.0, 22.0 ],
					"text" : "udpreceive 7500"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-43",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 682.0, 167.708326935768127, 150.0, 34.0 ],
					"text" : "daca e 1 sa pornesca microfonu;"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-39",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 576.0, 176.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"bgfillcolor_angle" : 270.0,
					"bgfillcolor_autogradient" : 0.0,
					"bgfillcolor_color" : [ 0.368627450980392, 0.666666666666667, 0.254901960784314, 1.0 ],
					"bgfillcolor_color1" : [ 0.368627450980392, 0.666666666666667, 0.254901960784314, 1.0 ],
					"bgfillcolor_color2" : [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
					"bgfillcolor_proportion" : 0.5,
					"bgfillcolor_type" : "gradient",
					"id" : "obj-37",
					"items" : [ "NONE", ",", "LIVE", ",", "Playlist" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 576.0, 135.0, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-35",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 576.0, 299.999988555908203, 68.0, 22.0 ],
					"text" : "selector~ 2"
				}

			}
, 			{
				"box" : 				{
					"basictuning" : 0,
					"data" : 					{
						"clips" : [  ]
					}
,
					"followglobaltempo" : 0,
					"formantcorrection" : 0,
					"id" : "obj-30",
					"maxclass" : "playlist~",
					"mode" : "basic",
					"numinlets" : 1,
					"numoutlets" : 5,
					"originallength" : [ 0 ],
					"originaltempo" : 0,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 762.0, 230.0, 150.0, 92.0 ],
					"pitchcorrection" : 0,
					"quality" : "basic",
					"saved_attribute_attributes" : 					{
						"candicane2" : 						{
							"expression" : ""
						}
,
						"candicane3" : 						{
							"expression" : ""
						}
,
						"candicane4" : 						{
							"expression" : ""
						}
,
						"candicane5" : 						{
							"expression" : ""
						}
,
						"candicane6" : 						{
							"expression" : ""
						}
,
						"candicane7" : 						{
							"expression" : ""
						}
,
						"candicane8" : 						{
							"expression" : ""
						}

					}
,
					"timestretch" : [ 0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"maxclass" : "ezadc~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 686.0, 193.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 280.208322644233704, 62.208331227302551, 150.0, 20.0 ],
					"text" : "opreste program"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 267.708323121070862, 38.249998807907104, 63.0, 22.0 ],
					"text" : "/shutdown"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 144.791661143302917, 35.416665315628052, 61.458330988883972, 34.0 ],
					"text" : "camera ON/OFF"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 105.208329319953918, 167.708326935768127, 78.0, 22.0 ],
					"text" : "/camera/stop"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 3,
					"outlettype" : [ "bang", "bang", "" ],
					"patching_rect" : [ 69.791664004325867, 110.416662454605103, 60.0, 22.0 ],
					"text" : "select 1 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 212.499991893768311, 238.541657567024231, 137.0, 22.0 ],
					"text" : "udpsend 127.0.0.1 7411"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 14.583332777023315, 167.708326935768127, 89.0, 22.0 ],
					"text" : "/camera/start 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 69.791664004325867, 8.333333015441895, 66.0, 66.0 ],
					"svg" : ""
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"midpoints" : [ 114.708329319953918, 216.833332538604736, 221.999991893768311, 216.833332538604736 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-12", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 1 ],
					"order" : 0,
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"order" : 1,
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"midpoints" : [ 277.208323121070862, 221.624998927116394, 221.999991893768311, 221.624998927116394 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 1 ],
					"source" : [ "obj-29", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 1 ],
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 2 ],
					"source" : [ "obj-30", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-39", 0 ],
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 0 ],
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-29", 0 ],
					"midpoints" : [ 79.291664004325867, 88.166666507720947, 695.5, 88.166666507720947 ],
					"order" : 0,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"order" : 1,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-46", 0 ],
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 1 ],
					"source" : [ "obj-46", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 1 ],
					"source" : [ "obj-46", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-60", 1 ],
					"source" : [ "obj-46", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 1 ],
					"source" : [ "obj-46", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"midpoints" : [ 24.083332777023315, 216.7916659116745, 221.999991893768311, 216.7916659116745 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 0 ],
					"midpoints" : [ 99.791664004325867, 152.166664600372314, 114.708329319953918, 152.166664600372314 ],
					"source" : [ "obj-8", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"midpoints" : [ 79.291664004325867, 154.166664600372314, 24.083332777023315, 154.166664600372314 ],
					"source" : [ "obj-8", 0 ]
				}

			}
 ],
		"originid" : "pat-69",
		"parameters" : 		{
			"obj-21::obj-10" : [ "Damp Active", "Active", 0 ],
			"obj-21::obj-108::obj-90" : [ "number", "number", 0 ],
			"obj-21::obj-11" : [ "Modulation Active", "Active", 0 ],
			"obj-21::obj-14" : [ "Position Active", "Active", 0 ],
			"obj-21::obj-1::obj-1::obj-12::obj-70" : [ "hirt.val[6]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-1::obj-44::obj-70" : [ "hirt.val[5]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-1::obj-45::obj-70" : [ "hirt.val[4]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-1::obj-46::obj-70" : [ "hirt.val[3]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-1::obj-47::obj-70" : [ "hirt.val[2]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-1::obj-48::obj-70" : [ "hirt.val[1]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-1::obj-49" : [ "Length Mode", "Length Mode", 0 ],
			"obj-21::obj-1::obj-1::obj-53" : [ "Direct Mode", "Direct Mode", 0 ],
			"obj-21::obj-1::obj-1::obj-9" : [ "Reverse", "Reverse", 0 ],
			"obj-21::obj-1::obj-1::obj-97::obj-70" : [ "hirt.val", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-100::obj-70" : [ "hirt.val[10]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-101::obj-70" : [ "hirt.val[7]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-36::obj-70" : [ "hirt.val[14]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-79::obj-70" : [ "hirt.val[11]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-81::obj-70" : [ "hirt.val[8]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-88::obj-70" : [ "hirt.val[15]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-92::obj-70" : [ "hirt.val[12]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-96::obj-70" : [ "hirt.val[9]", "hirt.val", 0 ],
			"obj-21::obj-1::obj-2::obj-99::obj-70" : [ "hirt.val[13]", "hirt.val", 0 ],
			"obj-21::obj-24::obj-1::obj-28::obj-70" : [ "hirt.val[17]", "hirt.val", 0 ],
			"obj-21::obj-24::obj-1::obj-29::obj-70" : [ "hirt.val[16]", "hirt.val", 0 ],
			"obj-21::obj-24::obj-2::obj-25" : [ "Widen", "Widen", 0 ],
			"obj-21::obj-24::obj-2::obj-29::obj-70" : [ "hirt.val[18]", "hirt.val", 0 ],
			"obj-21::obj-24::obj-2::obj-49" : [ "Type", "Type", 0 ],
			"obj-21::obj-24::obj-2::obj-8::obj-70" : [ "hirt.val[19]", "hirt.val", 0 ],
			"obj-21::obj-28" : [ "PATCH/PRESS", "PATCH/PRESS", 0 ],
			"obj-21::obj-31::obj-17::obj-70" : [ "hirt.val[28]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-19::obj-70" : [ "hirt.val[27]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-21" : [ "EQ Routing", "Active", 0 ],
			"obj-21::obj-31::obj-22::obj-70" : [ "hirt.val[26]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-50::obj-70" : [ "hirt.val[25]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-51::obj-70" : [ "hirt.val[24]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-53::obj-70" : [ "hirt.val[23]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-54::obj-70" : [ "hirt.val[22]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-55::obj-70" : [ "hirt.val[21]", "hirt.val", 0 ],
			"obj-21::obj-31::obj-56::obj-70" : [ "hirt.val[20]", "hirt.val", 0 ],
			"obj-21::obj-36::obj-114::obj-35" : [ "Drop A", "live.drop", 3 ],
			"obj-21::obj-36::obj-114::obj-65" : [ "Drop B", "live.drop", 3 ],
			"obj-21::obj-36::obj-131::obj-10" : [ "Category Menu", "Category Menu", 0 ],
			"obj-21::obj-36::obj-131::obj-11" : [ "IR Menu", "IR Menu", 0 ],
			"obj-21::obj-36::obj-49" : [ "Select IR", "Select", 0 ],
			"obj-21::obj-36::obj-53" : [ "Mode IR", "Mode", 0 ],
			"obj-21::obj-3::obj-59::obj-70" : [ "hirt.val[33]", "hirt.val", 0 ],
			"obj-21::obj-3::obj-62::obj-70" : [ "hirt.val[29]", "hirt.val", 0 ],
			"obj-21::obj-3::obj-63::obj-70" : [ "hirt.val[30]", "hirt.val", 0 ],
			"obj-21::obj-3::obj-64::obj-70" : [ "hirt.val[31]", "hirt.val", 0 ],
			"obj-21::obj-3::obj-65::obj-70" : [ "hirt.val[32]", "hirt.val", 0 ],
			"obj-21::obj-5" : [ "Realtime Tabs", "Realtime", 0 ],
			"obj-21::obj-79" : [ "Offline Tabs", "Offline", 0 ],
			"obj-21::obj-8" : [ "Shape Active", "Active", 0 ],
			"parameterbanks" : 			{
				"0" : 				{
					"index" : 0,
					"name" : "",
					"parameters" : [ "-", "-", "-", "-", "-", "-", "-", "-" ]
				}

			}
,
			"parameter_overrides" : 			{
				"obj-21::obj-1::obj-1::obj-12::obj-70" : 				{
					"parameter_exponent" : 2.5,
					"parameter_initial" : 15000.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[6]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 100.0, 30000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 2
				}
,
				"obj-21::obj-1::obj-1::obj-44::obj-70" : 				{
					"parameter_exponent" : 2.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[5]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 1000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 2
				}
,
				"obj-21::obj-1::obj-1::obj-45::obj-70" : 				{
					"parameter_exponent" : 2.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[4]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 1000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 2
				}
,
				"obj-21::obj-1::obj-1::obj-46::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[3]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-1::obj-47::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[2]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-1::obj-48::obj-70" : 				{
					"parameter_exponent" : 1.58,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[1]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 50.0, 200.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-1::obj-97::obj-70" : 				{
					"parameter_exponent" : 1.01,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_modmode" : 0,
					"parameter_range" : [ 1.0, 200.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-2::obj-100::obj-70" : 				{
					"parameter_exponent" : 4.0,
					"parameter_initial" : 1000.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[10]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 30.0, 18000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-1::obj-2::obj-101::obj-70" : 				{
					"parameter_exponent" : 4.0,
					"parameter_initial" : 8000.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[7]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 30.0, 18000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-1::obj-2::obj-36::obj-70" : 				{
					"parameter_exponent" : 1.189901,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[14]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 20.0, 200.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-2::obj-79::obj-70" : 				{
					"parameter_exponent" : 1.189901,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[11]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 20.0, 200.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-2::obj-81::obj-70" : 				{
					"parameter_exponent" : 1.189901,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[8]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 20.0, 200.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-1::obj-2::obj-88::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 1.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[15]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 2.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 1
				}
,
				"obj-21::obj-1::obj-2::obj-92::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.707107,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[12]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 2.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 1
				}
,
				"obj-21::obj-1::obj-2::obj-96::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 1.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[9]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 2.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 1
				}
,
				"obj-21::obj-1::obj-2::obj-99::obj-70" : 				{
					"parameter_exponent" : 4.0,
					"parameter_initial" : 125.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 1,
					"parameter_longname" : "hirt.val[13]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 30.0, 18000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-24::obj-1::obj-28::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[17]",
					"parameter_modmode" : 0,
					"parameter_range" : [ -100.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-24::obj-1::obj-29::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[16]",
					"parameter_modmode" : 0,
					"parameter_range" : [ -50.0, 50.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 6
				}
,
				"obj-21::obj-24::obj-2::obj-29::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 1.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[18]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 2.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-24::obj-2::obj-8::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 50.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[19]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-31::obj-17::obj-70" : 				{
					"parameter_exponent" : 3.0,
					"parameter_initial" : 0.5,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[28]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 18.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 10
				}
,
				"obj-21::obj-31::obj-19::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[27]",
					"parameter_modmode" : 0,
					"parameter_range" : [ -18.0, 18.0 ],
					"parameter_type" : 0,
					"parameter_units" : " ",
					"parameter_unitstyle" : 4
				}
,
				"obj-21::obj-31::obj-22::obj-70" : 				{
					"parameter_exponent" : 4.0,
					"parameter_initial" : 125.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[26]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 10.0, 18000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-31::obj-50::obj-70" : 				{
					"parameter_exponent" : 3.0,
					"parameter_initial" : 0.707107,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[25]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 18.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 10
				}
,
				"obj-21::obj-31::obj-51::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[24]",
					"parameter_modmode" : 0,
					"parameter_range" : [ -18.0, 18.0 ],
					"parameter_type" : 0,
					"parameter_units" : " ",
					"parameter_unitstyle" : 4
				}
,
				"obj-21::obj-31::obj-53::obj-70" : 				{
					"parameter_exponent" : 4.0,
					"parameter_initial" : 1000.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[23]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 10.0, 18000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-31::obj-54::obj-70" : 				{
					"parameter_exponent" : 3.0,
					"parameter_initial" : 0.5,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[22]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.05, 18.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 10
				}
,
				"obj-21::obj-31::obj-55::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[21]",
					"parameter_modmode" : 0,
					"parameter_range" : [ -18.0, 18.0 ],
					"parameter_type" : 0,
					"parameter_units" : " ",
					"parameter_unitstyle" : 4
				}
,
				"obj-21::obj-31::obj-56::obj-70" : 				{
					"parameter_exponent" : 4.0,
					"parameter_initial" : 8000.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[20]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 10.0, 18000.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 3
				}
,
				"obj-21::obj-3::obj-59::obj-70" : 				{
					"parameter_exponent" : 2.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[33]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 200.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 2
				}
,
				"obj-21::obj-3::obj-62::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[29]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-3::obj-63::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 100.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[30]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}
,
				"obj-21::obj-3::obj-64::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 0.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[31]",
					"parameter_modmode" : 0,
					"parameter_range" : [ -20.0, 20.0 ],
					"parameter_type" : 0,
					"parameter_units" : " ",
					"parameter_unitstyle" : 4
				}
,
				"obj-21::obj-3::obj-65::obj-70" : 				{
					"parameter_exponent" : 1.0,
					"parameter_initial" : 50.0,
					"parameter_initial_enable" : 0,
					"parameter_invisible" : 0,
					"parameter_longname" : "hirt.val[32]",
					"parameter_modmode" : 0,
					"parameter_range" : [ 0.0, 100.0 ],
					"parameter_type" : 0,
					"parameter_unitstyle" : 5
				}

			}
,
			"inherited_shortname" : 1
		}
,
		"dependency_cache" : [ 			{
				"name" : "HIRT_HISSTools_Logo.png",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/misc/HIRT_image",
				"type" : "PNG",
				"implicit" : 1
			}
, 			{
				"name" : "ambidecode~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "ambiencode~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "bufresample~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "bufreverse~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "hirt.buffer.filter.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.convolutionreverb~.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.convolvestereo~.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.convrvrb.realtime~.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.damping.cascade.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.dial.jspainter.js",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/javascript",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.dial.linear.only.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.dial.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.size.resample.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt.svfcoeff.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_base_name.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_conv_rvrb_zoom.txt",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_convolution_rt_library.genexpr",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/code",
				"type" : "GenX",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_convrvrb_rt_part1.gendsp",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/code",
				"type" : "gDSP",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_convrvrb_rt_part3.gendsp",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/code",
				"type" : "gDSP",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_convrvrb_rt_part5.gendsp",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/code",
				"type" : "gDSP",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_cr_info_view.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_data_colls.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_eq.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_eq_library.genexpr",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/code",
				"type" : "GenX",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_file_check.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_file_ir_display.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_file_loading.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_file_picker.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_file_set.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_filter_type.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_folder.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_gain_and_display.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_gain_params.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_interface_damp.js",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/jsui",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_interface_eq.js",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/jsui",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_interface_mod.js",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/jsui",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_interface_pos.js",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/jsui",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_ir.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_loading_scheme.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_nan_fix.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_output.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_partition_copy_buffers.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_partition_early.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_partition_fix_length.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_partition_late.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_size_resample_feed.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_tab_damp.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_tab_modulation.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_tab_position.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_tab_shape.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_tabs_offline.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_tabs_realtime.maxpat",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/patchers/HIRT_reverb/HIRT_reverb_support",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "hirt_zoom_factor.js",
				"bootpath" : "~/OneDrive/Documente/Max 9/Packages/HISSTools Impulse Response Toolbox (HIRT)/javascript",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "iraverage~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "ircropfade~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "irdisplay~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "irmix~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "irstats~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "irtrimnorm~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "morphfilter~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "multiconvolve~.mxe64",
				"type" : "mx64"
			}
, 			{
				"name" : "spectrumdraw~.mxe64",
				"type" : "mx64"
			}
 ],
		"autosave" : 0
	}

}
