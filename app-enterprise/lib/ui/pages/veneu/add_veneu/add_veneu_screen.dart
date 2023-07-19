import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/core/models/picked_image.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/core/models/responses/operational_time_response.dart';
import 'package:myarcher_enterprise/core/models/responses/schedule_holiday_response.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/pick_location/pick_location_screen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/add_veneu_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/config_operational/config_operational_screen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/widget/item_field_label.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/widget/item_other_facility.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/widget/item_photo.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/widget/item_type_field.dart';
import 'package:myarcher_enterprise/ui/shared/appbar.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/checkbox.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/ui/shared/fullscreen_image.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/sliver_grid_delegate_fixed.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:path/path.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../../utils/generated_data.dart';

class AddVeneuScreen extends StatefulWidget {
  final String? id;

  const AddVeneuScreen({Key? key, this.id}) : super(key: key);

  @override
  State<AddVeneuScreen> createState() => _AddVeneuScreenState();
}

class _AddVeneuScreenState extends State<AddVeneuScreen> {
  var controller = AddVeneuController();
  final ImagePicker _picker = ImagePicker();
  EventBus eventBus = EventBus();

  @override
  void initState() {
    if (widget.id != null) {
      controller.selectedVenueId.value = int.parse(widget.id!);
    }
    controller.initController();
    // WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit() {
    controller.apiGetFacility();
    if (widget.id == null) {
      controller.selectedImages.add(PickedImage(isPicker: true, image: File("")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Translator.informationField.tr,
          onClick: () {
            onWillPop();
          },
        ),
        body: Stack(
          children: [
            Obx(() => controller.selectedState.value == 0
                ? ListView(
                    children: [
                      _viewGeneralInfo(),
                      _divider(),
                      _viewFieldLocation(),
                      _divider(),
                      _viewFacility(),
                      _divider(),
                      _viewOtherFacility(),
                      _divider(),
                      _viewPhotos(),
                      Obx(() => hSpace((controller.dataVenue.value.status ==
                              StatusVenue.lengkapiData)
                          ? 100
                          : 70))
                    ],
                  )
                : ConfigOperationalScreen(
                    id: controller.dataVenue.value.id!,
                    schedules: controller.schedules,
                    onReload: () {
                      controller.operationalController
                          .apiListScheduleOperational(
                              id: controller.dataVenue.value.id!,
                              onFinish: (OperationalTimeResponse resp) {
                                controller.schedules.clear();
                                controller.schedules.addAll(resp.data!);
                                setState(() {});
                              });

                      controller.holidayController.apiListScheduleHoliday(
                          id: controller.dataVenue.value.id!,
                          onFinish: (ScheduleHolidayResponse resp) {
                            controller.holidaySchedules.clear();
                            controller.holidaySchedules.addAll(resp.data!);
                            setState(() {});
                          });
                    },
                    holidaySchedules: controller.holidaySchedules,
                    onCheckValid: (valid, capacties) {
                      controller.optionDistances.clear();
                      controller.optionDistances.addAll(capacties);

                      controller.isValidToPublish.value = valid;
                    },
                    optionDistances: controller.optionDistances,
                    arrowQty: controller.arrowQty.value,
                    peopleQty: controller.peopleQty.value,
                    targetQty: controller.targetQty.value,
                    budrestQty: controller.budrestQty.value,
                    onAssignData: (int budrest, int target, int arrow, int people) {
                      controller.budrestQty.value = budrest;
                      controller.targetQty.value = target;
                      controller.arrowQty.value = arrow;
                      controller.peopleQty.value = people;
                    },
                  )),
            _viewButtons()
          ],
        ),
      ),
    ));
  }

  Future<bool> onWillPop() async {
    if (controller.isEditable.value) {
      if (controller.ifAnyFormFilled()) {
        showConfirmDialog(Get.context!,
            content: Translator.msgBackFromAjukanData.tr,
            showIcon: true,
            assets: Assets.icons.icAlert,
            typeAsset: "svg",
            showCloseTopCorner: true,
            btn1: Translator.backToDashboard.tr,
            btn3: Translator.backAndSaveAsDraft.tr, onClickBtn1: () {
          Navigator.pop(Get.context!, true);
        }, onClickBtn3: () {
          if (controller.selectedVenueId.value != 0) {
            controller.apiUpdateVeneu(isDraft: true);
          } else {
            controller.apiAddVeneu(isDraft: true);
          }
        });
      }
    } else if (controller.dataVenue.value.status == StatusVenue.lengkapiData) {
      if (controller.optionDistances.isNotEmpty ||
          controller.budrestQty.value > 0 ||
          controller.targetQty.value > 0 ||
          controller.arrowQty.value > 0 ||
          controller.peopleQty.value > 0) {
        showConfirmDialog(Get.context!,
            content: Translator.msgBackFromCapacity.tr,
            showIcon: true,
            assets: Assets.icons.icAlert,
            typeAsset: "svg",
            showCloseTopCorner: true,
            btn1: Translator.backToDashboard.tr,
            btn3: Translator.continueFillDetail.tr, onClickBtn1: () {
          Navigator.pop(Get.context!, true);
        }, onClickBtn3: () {});
      } else {
        Navigator.pop(Get.context!, true);
      }
    } else {
      Navigator.pop(Get.context!, true);
    }
    return false;
  }

  _viewGeneralInfo() {
    return Container(
      padding: EdgeInsets.all(wValue(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.generalInformation.tr,
              style: textBaseBold.copyWith(color: AppColor.gray600)),
          hSpace(17),
          ItemFieldLabel(
            title: Translator.fieldName.tr,
            required: true,
          ),
          hSpace(5),
          Obx(() => EditText(
              controller: controller.fieldNameC.value,
              hintText: Translator.inputFieldName.tr,
              bgColor: AppColor.gray50,
              borderColor: AppColor.gray50,
              enable: controller.isEditable.value,
              validatorText: controller.errorFieldName.value.isEmpty
                  ? null
                  : controller.errorFieldName.value,
              onChange: (value) {
                controller.errorFieldName.value =
                    (value.isEmpty) ? Translator.cantEmpty.tr : "";
                controller.checkValidation();
              })),
          hSpace(17),
          ItemFieldLabel(title: Translator.shortDesc.tr, required: false),
          hSpace(5),
          Obx(() => EditText(
              controller: controller.shortDescC.value,
              hintText: Translator.describeShortDescription.tr,
              maxLines: 4,
              bgColor: AppColor.gray50,
              enable: controller.isEditable.value,
              borderColor: AppColor.gray50,
              textInputAction: TextInputAction.newline,
              textInputType: TextInputType.multiline,
              contentPadding: EdgeInsets.symmetric(
                  vertical: hValue(10), horizontal: wValue(15)))),
          hSpace(17),
          ItemFieldLabel(
            title: Translator.typeField.tr,
            required: true,
          ),
          hSpace(5),
          Obx(
            () => Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ItemTypeField(
                    item: 'Indoor',
                    isSelected: controller.selectedType.value == 0,
                    onClick: () {
                      if (controller.isEditable.value)
                        controller.selectedType.value = 0;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ItemTypeField(
                    item: 'Outdoor',
                    isSelected: controller.selectedType.value == 1,
                    onClick: () {
                      if (controller.isEditable.value)
                        controller.selectedType.value = 1;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ItemTypeField(
                    item: Translator.both.tr,
                    isSelected: controller.selectedType.value == 2,
                    onClick: () {
                      if (controller.isEditable.value)
                        controller.selectedType.value = 2;
                    },
                  ),
                ),
              ],
            ),
          ),
          hSpace(26),
          ItemFieldLabel(
            title: Translator.contact.tr,
            required: true,
          ),
          hSpace(5),
          Obx(() => EditText(
              controller: controller.contactC.value,
              hintText: Translator.inputPhone.tr,
              bgColor: AppColor.gray50,
              borderColor: AppColor.gray50,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              readOnly: false,
              enable: controller.isEditable.value,
              validatorText: controller.errorContact.value.isEmpty
                  ? null
                  : controller.errorContact.value,
              onChange: (value) {
                controller.errorContact.value =
                    value.toString().isEmpty ? Translator.cantEmpty.tr : "";
                controller.checkIfNumberSameWithPhoneUser(value);
                controller.checkValidation();
              })),
          hSpace(10),
          Obx(() => (controller.isEditable.value)
              ? CheckBox(
                  label: Translator.sameWithPhoneBusiness.tr,
                  isChecked: controller.sameWithPhoneBusiness.value,
                  onChange: () {
                    controller.sameWithPhoneBusiness.value =
                        !controller.sameWithPhoneBusiness.value;
                    controller.contactC.value.text =
                        controller.sameWithPhoneBusiness.value
                            ? controller.user.value.phoneNumber
                            : "";
                    controller.checkValidation();
                  })
              : Container()),
        ],
      ),
    );
  }

  _viewFieldLocation() {
    return Container(
      padding: EdgeInsets.all(wValue(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(Translator.fieldLocation.tr,
                      style: textBaseBold.copyWith(color: AppColor.gray600)),
                  wSpace(3),
                  Text("*",
                      style:
                          textBaseBold.copyWith(color: AppColor.negativeRed)),
                ],
              ),
              Obx(() => (controller.isEditable.value)
                  ? InkWell(
                      child: Text(Translator.setLocation.tr,
                          style: textSmBold.copyWith(
                              color: AppColor.colorPrimary)),
                      onTap: () async {
                        PickedLocation? result = await Navigator.push(
                          Get.context!,
                          MaterialPageRoute(
                              builder: (context) =>
                                  controller.selectedLocation.value.address !=
                                          null
                                      ? PickLocationScreen(
                                          currentLoc:
                                              controller.selectedLocation.value,
                                        )
                                      : const PickLocationScreen()),
                        );
                        if (result != null) {
                          controller.selectedLocation.value = result;
                          controller.addressFieldC.value.text =
                              result.address ?? "";

                          controller.markers.clear();
                          controller.updateCurrentPosition();
                          controller.checkValidation();
                        }
                      },
                    )
                  : Container())
            ],
          ),
          hSpace(15),
          Obx(() => Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: (controller.errorLocationMap.isNotEmpty)
                      ? Colors.red
                      : Colors.white,
                  width: 1,
                )),
                height: hValue(250),
                child: GoogleMap(
                  initialCameraPosition: controller.currentCameraMap.value,
                  markers: Set<Marker>.of(controller.markers.values),
                  mapType: MapType.normal,
                  onTap: (latlng) async {
                    if (!controller.isEditable.value) {
                      return;
                    }
                    PickedLocation? result = await Navigator.push(
                      Get.context!,
                      MaterialPageRoute(
                          builder: (context) =>
                              controller.selectedLocation.value.address != null
                                  ? PickLocationScreen(
                                      currentLoc:
                                          controller.selectedLocation.value,
                                    )
                                  : const PickLocationScreen()),
                    );
                    if (result != null) {
                      controller.selectedLocation.value = result;
                      controller.addressFieldC.value.text =
                          result.address ?? "";

                      controller.markers.clear();
                      controller.updateCurrentPosition();
                      controller.checkValidation();
                    }
                  },
                  onMapCreated: (GoogleMapController ctrl) {
                    if(controller.facilities.isEmpty) afterInit();
                    controller.mapController = ctrl;
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                ),
              )),
          Obx(() => (controller.errorLocationMap.isNotEmpty)
              ? Container(
                  margin: EdgeInsets.only(left: wValue(10), top: hValue(10)),
                  child: Text(
                    Translator.chooseLocationFirst.tr,
                    style: regularTextFont.copyWith(
                        fontSize: fontSize(10), color: Colors.red),
                  ),
                )
              : Container()),
          Obx(() => (controller.selectedLocation.value.address != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSpace(17),
                    ItemFieldLabel(
                        title: Translator.fieldAddress.tr, required: true),
                    hSpace(5),
                    Obx(() => EditText(
                        controller: controller.addressFieldC.value,
                        hintText: Translator.inputAddress.tr,
                        bgColor: AppColor.gray50,
                        enable: controller.isEditable.value,
                        borderColor: AppColor.gray50,
                        validatorText:
                            controller.errorFieldAddress.value.isEmpty
                                ? null
                                : controller.errorFieldAddress.value,
                        onChange: (value) {
                          controller.errorFieldAddress.value =
                              value.toString().isEmpty
                                  ? Translator.cantEmpty.tr
                                  : "";
                          controller.checkValidation();
                        })),
                    hSpace(17),
                    ItemFieldLabel(
                      title: Translator.chooseProvince.tr,
                      required: true,
                    ),
                    hSpace(5),
                    Obx(() => EditText(
                        controller: controller.provinceC.value,
                        hintText: Translator.chooseProvince.tr,
                        bgColor: AppColor.gray50,
                        borderColor: AppColor.gray50,
                        readOnly: true,
                        enable: controller.isEditable.value,
                        rightIcon: Assets.icons.icArrowDown,
                        validatorText: controller.errorProvince.value.isEmpty
                            ? null
                            : controller.errorProvince.value,
                        onClick: () {
                          modalBottomProvince(
                              onItemSelected: (RegionModel item) {
                            controller.selectedProvince.value = item;
                            controller.provinceC.value.text = item.name ?? "";

                            controller.checkValidation();
                          });
                        })),
                    hSpace(17),
                    ItemFieldLabel(
                      title: Translator.chooseCity.tr,
                      required: true,
                    ),
                    hSpace(5),
                    Obx(() => EditText(
                        controller: controller.cityC.value,
                        hintText: Translator.chooseCity.tr,
                        bgColor: AppColor.gray50,
                        borderColor: AppColor.gray50,
                        readOnly: true,
                        enable: controller.isEditable.value,
                        rightIcon: Assets.icons.icArrowDown,
                        validatorText: controller.errorCity.value.isEmpty
                            ? null
                            : controller.errorCity.value,
                        onClick: () {
                          if (controller.selectedProvince.value.id == null) {
                            Toast().errorToast(
                                msg: Translator.provinceMustFill.tr);
                            return;
                          }

                          modalBottomCity(
                              onItemSelected: (item) {
                                controller.selectedCity.value = item;
                                controller.cityC.value.text = item.name ?? "";

                                controller.checkValidation();
                              },
                              idProvince:
                                  "${controller.selectedProvince.value.id}");
                        })),
                  ],
                )
              : Container()),
        ],
      ),
    );
  }

  _viewFacility() {
    return Container(
      padding: EdgeInsets.all(wValue(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(Translator.facility.tr,
                  style: textBaseBold.copyWith(color: AppColor.gray600)),
              wSpace(5),
              Text("*", style: textBaseBold.copyWith(color: Colors.red))
            ],
          ),
          hSpace(17),
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: wValue(10), right: wValue(10)),
                    child: GridView.builder(
                      itemCount: controller.facilities.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CheckBox(
                          label: controller.facilities[index].name ?? "",
                          isChecked: controller.facilities[index].checked!,
                          onChange: () {
                            if (!controller.isEditable.value) {
                              return;
                            }
                            var currentData = controller.facilities[index];
                            controller.facilities[index] = FacilityModel(
                                id: currentData.id,
                                checked: !currentData.checked!,
                                updatedAt: currentData.updatedAt,
                                createdAt: currentData.createdAt,
                                icon: currentData.icon,
                                eoId: currentData.eoId,
                                name: currentData.name);
                            controller.checkValidation();
                          }),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 2,
                              crossAxisSpacing: wValue(10),
                              mainAxisSpacing: hValue(10),
                              height: hValue(20)),
                    ),
                  ),
                  if (controller.errorFacility.isNotEmpty)
                    Container(
                      margin:
                          EdgeInsets.only(left: wValue(10), top: hValue(10)),
                      child: Text(
                        Translator.cantEmpty.tr,
                        style: regularTextFont.copyWith(
                            fontSize: fontSize(10), color: Colors.red),
                      ),
                    ),
                ],
              )),
        ],
      ),
    );
  }

  _viewOtherFacility() {
    return Container(
      padding: EdgeInsets.all(wValue(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Translator.otherFacility.tr,
                  style: textBaseBold.copyWith(color: AppColor.gray600)),
              Obx(() => (controller.isEditable.value)
                  ? InkWell(
                      child: Text(Translator.addNew.tr,
                          style: textSmBold.copyWith(
                              color: AppColor.colorPrimary)),
                      onTap: () {
                        showInputWordDialog(
                            onSubmit: (String item) {
                              controller.otherFacilities.add(FacilityModel(
                                  icon: null,
                                  name: item,
                                  eoId: 0,
                                  createdAt: "",
                                  updatedAt: "",
                                  id: 0,
                                  checked: false));
                            },
                            textButtonNeg: Translator.cancel.tr,
                            textButtonPos: Translator.save.tr,
                            title: Translator.addOtherFacility.tr);
                      },
                    )
                  : Container()),
            ],
          ),
          hSpace(17),
          Obx(() => (controller.otherFacilities.isEmpty)
              ? Text(
                  Translator.descOtherFacility.tr,
                  style: textSmRegular.copyWith(color: AppColor.gray400),
                )
              : Column(
                  children: [
                    for (var item in controller.otherFacilities)
                      ItemOtherFacility(
                          item: item,
                          isEditable: controller.isEditable.value,
                          onAction: () {
                            var actions =
                                GeneratedData().actionsOtherFacility();
                            if (item.eoId != 0) {
                              actions.removeAt(0);
                            }
                            modalBottomDynamicAction(
                                actions: actions,
                                onItemSelected: (action) {
                                  if (action
                                      .toString()
                                      .contains(Translator.edit.tr)) {
                                    showInputWordDialog(
                                        currentData: item.name,
                                        onSubmit: (String data) {
                                          controller.otherFacilities[controller
                                                  .otherFacilities
                                                  .indexWhere(
                                                      (p0) => p0 == item)] =
                                              FacilityModel(
                                                  checked: item.checked,
                                                  id: item.id,
                                                  updatedAt: item.updatedAt,
                                                  createdAt: item.updatedAt,
                                                  eoId: item.eoId,
                                                  name: data,
                                                  icon: item.icon);
                                        },
                                        textButtonNeg: Translator.cancel.tr,
                                        textButtonPos: Translator.update.tr,
                                        title: Translator.addOtherFacility.tr);
                                  } else {
                                    showConfirmDialog(Get.context!,
                                        content:
                                            Translator.msgDeleteFacility.tr,
                                        showIcon: true,
                                        assets: Assets.icons.icAlert,
                                        typeAsset: "svg",
                                        showCloseTopCorner: true,
                                        btn1: Translator.canceling.tr,
                                        btn3: Translator.delete.tr,
                                        onClickBtn1: () {
                                      Get.back();
                                    }, onClickBtn3: () {
                                      controller.otherFacilities.remove(item);
                                    });
                                  }
                                });
                          })
                  ],
                )),
          hSpace(10),
          Obx(() => (controller.isEditable.value)
              ? Button(
                  title: Translator.chooseFromCurrent.tr,
                  textSize: fontSize(14),
                  enable: true,
                  onClick: () {
                    modalBottomExistOtherFacilities(onItemSelected: (data) {
                      for (var item in data) {
                        controller.otherFacilities.add(item);
                      }
                    });
                  },
                  color: AppColor.colorPrimary,
                  height: hValue(36))
              : Container())
        ],
      ),
    );
  }

  _viewPhotos() {
    return Container(
      padding: EdgeInsets.all(wValue(20)),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Translator.photoFieldAndFacility.tr,
                  style: textBaseBold.copyWith(color: AppColor.gray600)),
              Container(
                margin: EdgeInsets.symmetric(vertical: hValue(5)),
                padding: EdgeInsets.all(wValue(10)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.gray50,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.icInfo),
                    wSpace(10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        Translator.descPhotoFieldAndFacility.tr,
                        style: textXsRegular.copyWith(color: AppColor.gray500),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                itemCount: controller.selectedImages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ItemPhoto(
                  onPhotoClicked: () {
                    Get.to(() => FullscreenImage(
                        image: controller.selectedImages[index].image != null
                            ? controller.selectedImages[index].image!.path
                            : controller.selectedImages[index].url!.file!));
                  },
                  isEditable: controller.isEditable.value,
                  data: controller.selectedImages[index],
                  onClick: () {
                    if (controller.selectedImages[index].isPicker) {
                      modalBottomDynamicAction(
                          actions: GeneratedData().actionChooseImage(),
                          onItemSelected: (action) async {
                            XFile? image;
                            if (action
                                .toString()
                                .contains(Translator.camera.tr)) {
                              image = await _picker.pickImage(
                                  source: ImageSource.camera);
                            } else {
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                            }

                            CroppedFile? croppedFile = await ImageCropper()
                                .cropImage(
                                    sourcePath: image!.path,
                                    aspectRatioPresets: [
                                  CropAspectRatioPreset.square,
                                  CropAspectRatioPreset.ratio3x2,
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.ratio4x3,
                                  CropAspectRatioPreset.ratio16x9
                                ],
                                    uiSettings: [
                                  AndroidUiSettings(
                                      toolbarTitle: Translator.appName.tr,
                                      toolbarColor: AppColor.colorPrimary,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                          CropAspectRatioPreset.original,
                                      lockAspectRatio: false),
                                  IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                  )
                                ]);
                            var newPath = image.path.replaceAll(
                                basename(croppedFile!.path),
                                "compress_${basename(croppedFile.path)}");
                            newPath = newPath.replaceAll("png", "jpg");
                            var newFile = await compressFile(
                                file: File(croppedFile.path),
                                quality: 50,
                                targetPath: newPath);
                            controller.manipulatePhotos(
                                action: "add",
                                data: PickedImage(
                                    isPicker: false,
                                    image: File(newFile?.path ?? "")));
                          });
                    }
                  },
                  onDelete: () {
                    showConfirmDialog(Get.context!,
                        content: Translator.msgDeletePhoto.tr,
                        showIcon: true,
                        assets: Assets.icons.icAlert,
                        typeAsset: "svg",
                        showCloseTopCorner: true,
                        btn1: Translator.canceling.tr,
                        btn3: Translator.delete.tr, onClickBtn1: () {
                      Get.back();
                    }, onClickBtn3: () {
                      if (controller.selectedImages[index].image != null) {
                        controller.manipulatePhotos(
                            action: "remove", index: index);
                      } else {
                        controller.apiDeleteImageVenue(
                            id: controller.selectedImages[index].url!.id!,
                            index: index);
                      }
                    });
                  },
                ),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 4,
                        crossAxisSpacing: wValue(10),
                        mainAxisSpacing: hValue(10),
                        height: hValue(65)),
              ),
              if (controller.errorPhoto.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: hValue(10)),
                  child: Text(
                    Translator.cantEmpty.tr,
                    style: regularTextFont.copyWith(
                        fontSize: fontSize(10), color: Colors.red),
                  ),
                ),
            ],
          )),
    );
  }

  _divider() {
    return Container(
      height: hValue(12),
      color: AppColor.gray50,
      width: Get.width,
    );
  }

  _viewButtons() {
    return Obx(
        () => (controller.dataVenue.value.status == StatusVenue.lengkapiData)
            ? _viewButtonsCompleteData()
            : (controller.isEditable.value)
                ? Positioned(
                    bottom: 0,
                    child: SimpleShadow(
                      sigma: 6,
                      opacity: 0.3,
                      child: Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          color: AppColor.white,
                        ),
                        padding: EdgeInsets.all(wValue(15)),
                        child: Obx(() => Button(
                            title: Translator.ajukan.tr,
                            color: controller.isValid.value
                                ? AppColor.colorPrimary
                                : AppColor.gray500,
                            enable: controller.isValid.value,
                            onClick: () {
                              showConfirmDialog(Get.context!,
                                  content: Translator.msgAjukanData.tr,
                                  showIcon: true,
                                  assets: Assets.icons.icAlert,
                                  typeAsset: "svg",
                                  btn1: Translator.checkAgain.tr,
                                  btn3: Translator.yesAjukanData.tr,
                                  onClickBtn1: () {}, onClickBtn3: () {
                                if (controller.isValid.value) {
                                  if (controller.selectedVenueId.value != 0) {
                                    controller.apiUpdateVeneu();
                                  } else {
                                    controller.apiAddVeneu();
                                  }
                                }
                              });
                            })),
                      ),
                    ),
                  )
                : Container());
  }

  _viewButtonsCompleteData() {
    return Obx(() => Positioned(
          bottom: 0,
          child: Column(
            children: [
              SimpleShadow(
                sigma: 6,
                opacity: 0.3,
                child: Container(
                    width: Get.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: AppColor.white,
                    ),
                    padding: EdgeInsets.all(wValue(15)),
                    child: Column(
                      children: [
                        Button(
                            title: controller.selectedState.value == 0
                                ? Translator.next.tr
                                : Translator.previous.tr,
                            color: Colors.white,
                            borderColor: AppColor.colorPrimary,
                            fontColor: AppColor.colorPrimary,
                            enable: true,
                            onClick: () {
                              if (controller.selectedState.value == 0) {
                                controller.selectedState.value += 1;
                              } else {
                                controller.selectedState.value -= 1;
                                eventBus.fire("assign_data_distance");
                              }
                            }),
                        hSpace(10),
                        Button(
                            title: Translator.publish.tr,
                            color: controller.isValidToPublish.value
                                ? AppColor.colorPrimary
                                : AppColor.gray500,
                            enable: controller.isValidToPublish.value,
                            onClick: () {
                              showConfirmDialog(Get.context!,
                                  content: Translator.msgCompleteData.tr,
                                  showIcon: true,
                                  assets: Assets.icons.icAlert,
                                  typeAsset: "svg",
                                  btn1: Translator.checkAgain.tr,
                                  btn3: Translator.yesAjukanData.tr,
                                  onClickBtn1: () {}, onClickBtn3: () {
                                controller.apiPublishVenue(onFinish: () {
                                  Navigator.pop(Get.context!, true);
                                });
                              });
                            })
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
