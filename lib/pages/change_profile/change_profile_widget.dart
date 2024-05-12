import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'change_profile_model.dart';
export 'change_profile_model.dart';

class ChangeProfileWidget extends StatefulWidget {
  const ChangeProfileWidget({
    super.key,
    required this.userRef,
  });

  final DocumentReference? userRef;

  @override
  State<ChangeProfileWidget> createState() => _ChangeProfileWidgetState();
}

class _ChangeProfileWidgetState extends State<ChangeProfileWidget> {
  late ChangeProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangeProfileModel());

    _model.yourNameFocusNode ??= FocusNode();

    _model.phoneFocusNode ??= FocusNode();

    _model.myBioFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: responsiveVisibility(
        context: context,
        desktop: false,
      )
          ? PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                actions: const [],
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 50.0,
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: Color(0xFF14181B),
                            size: 30.0,
                          ),
                          onPressed: () async {
                            context.pushNamed('profileOptions');
                          },
                        ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          '45e6kbnt' /* Chỉnh sửa thông tin cá nhân */,
                        ),
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Outfit',
                              color: const Color(0xFF14181B),
                              fontSize: 22.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                  centerTitle: true,
                  expandedTitleScale: 1.0,
                ),
                elevation: 0.0,
              ),
            )
          : null,
      body: SafeArea(
        top: true,
        child: StreamBuilder<UsersRecord>(
          stream: UsersRecord.getDocument(currentUserReference!),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }
            final columnUsersRecord = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final selectedMedia =
                              await selectMediaWithSourceBottomSheet(
                            context: context,
                            imageQuality: 80,
                            allowPhoto: true,
                            backgroundColor: const Color(0xFFF1F4F8),
                            textColor: const Color(0xFF14181B),
                            pickerFontFamily: 'Outfit',
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            setState(() => _model.isDataUploading = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];

                            var downloadUrls = <String>[];
                            try {
                              showUploadMessage(
                                context,
                                'Uploading file...',
                                showLoading: true,
                              );
                              selectedUploadedFiles = selectedMedia
                                  .map((m) => FFUploadedFile(
                                        name: m.storagePath.split('/').last,
                                        bytes: m.bytes,
                                        height: m.dimensions?.height,
                                        width: m.dimensions?.width,
                                        blurHash: m.blurHash,
                                      ))
                                  .toList();

                              downloadUrls = (await Future.wait(
                                selectedMedia.map(
                                  (m) async =>
                                      await uploadData(m.storagePath, m.bytes),
                                ),
                              ))
                                  .where((u) => u != null)
                                  .map((u) => u!)
                                  .toList();
                            } finally {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              _model.isDataUploading = false;
                            }
                            if (selectedUploadedFiles.length ==
                                    selectedMedia.length &&
                                downloadUrls.length == selectedMedia.length) {
                              setState(() {
                                _model.uploadedLocalFile =
                                    selectedUploadedFiles.first;
                                _model.uploadedFileUrl = downloadUrls.first;
                              });
                              showUploadMessage(context, 'Success!');
                            } else {
                              setState(() {});
                              showUploadMessage(
                                  context, 'Failed to upload data');
                              return;
                            }
                          }
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0E3E7),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 90.0,
                              height: 90.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                columnUsersRecord.photoUrl,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: TextFormField(
                    controller: _model.yourNameTextController ??=
                        TextEditingController(
                      text: columnUsersRecord.displayName,
                    ),
                    focusNode: _model.yourNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: FFLocalizations.of(context).getText(
                        'a59krpzx' /* Your Name */,
                      ),
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E3E7),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF4B39EF),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF14181B),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    validator: _model.yourNameTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: TextFormField(
                    controller: _model.phoneTextController ??=
                        TextEditingController(
                      text: columnUsersRecord.phoneNumber,
                    ),
                    focusNode: _model.phoneFocusNode,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: FFLocalizations.of(context).getText(
                        '6rz5fz5q' /* Phone Number */,
                      ),
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E3E7),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF4B39EF),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF14181B),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    validator: _model.phoneTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                  child: FlutterFlowDropDown<String>(
                    controller: _model.stateValueController ??=
                        FormFieldController<String>(
                      _model.stateValue ??= FFLocalizations.of(context).getText(
                        'y6mlokle' /* State */,
                      ),
                    ),
                    options: [
                      FFLocalizations.of(context).getText(
                        'ctgl65ec' /* State */,
                      ),
                      FFLocalizations.of(context).getText(
                        'j9zbqhk2' /* An Giang */,
                      ),
                      FFLocalizations.of(context).getText(
                        'ml5id8is' /* Bà Rịa-Vũng Tàu */,
                      ),
                      FFLocalizations.of(context).getText(
                        'oakqbh3s' /* Bắc Giang */,
                      ),
                      FFLocalizations.of(context).getText(
                        'ijn74yg8' /* Bắc Kạn */,
                      ),
                      FFLocalizations.of(context).getText(
                        'c42qqi38' /* Bạc Liêu */,
                      ),
                      FFLocalizations.of(context).getText(
                        'ye63dvt7' /* Bắc Ninh */,
                      ),
                      FFLocalizations.of(context).getText(
                        'tp7trcbv' /* Bến Tre */,
                      ),
                      FFLocalizations.of(context).getText(
                        'xk36kchs' /* Bình Định */,
                      ),
                      FFLocalizations.of(context).getText(
                        'w528ate2' /* Bình Dương */,
                      ),
                      FFLocalizations.of(context).getText(
                        'oa49puuq' /* Bình Phước */,
                      ),
                      FFLocalizations.of(context).getText(
                        'jyvzlaep' /* Bình Thuận */,
                      ),
                      FFLocalizations.of(context).getText(
                        'hm295h4l' /* Cà Mau */,
                      ),
                      FFLocalizations.of(context).getText(
                        'xv5u7tf0' /* Cần Thơ */,
                      ),
                      FFLocalizations.of(context).getText(
                        'llmqpxqr' /* Cao Bằng */,
                      ),
                      FFLocalizations.of(context).getText(
                        'jd8fmiwo' /* Đà Nẵng */,
                      ),
                      FFLocalizations.of(context).getText(
                        '4e33jcvp' /* Đắk Lắk */,
                      ),
                      FFLocalizations.of(context).getText(
                        '312eg6va' /* Đắk Nông */,
                      ),
                      FFLocalizations.of(context).getText(
                        'gnuf18xt' /* Điện Biên */,
                      ),
                      FFLocalizations.of(context).getText(
                        '0okm5lpr' /* Đồng Nai */,
                      ),
                      FFLocalizations.of(context).getText(
                        '8xy54c9h' /* Đồng Nai */,
                      ),
                      FFLocalizations.of(context).getText(
                        'cs18k2fm' /* Gia Lai */,
                      ),
                      FFLocalizations.of(context).getText(
                        'i9cp7mf8' /* Gia Lai */,
                      ),
                      FFLocalizations.of(context).getText(
                        'p1j72mkm' /* Hà Nam */,
                      ),
                      FFLocalizations.of(context).getText(
                        '4zq5q6b3' /* Hà Nội */,
                      ),
                      FFLocalizations.of(context).getText(
                        'iowatj1k' /* Hà Tĩnh */,
                      ),
                      FFLocalizations.of(context).getText(
                        'swc1na8n' /* Hải Dương */,
                      ),
                      FFLocalizations.of(context).getText(
                        'byi5300m' /* Hải Phòng */,
                      ),
                      FFLocalizations.of(context).getText(
                        'zdjb4ou8' /* Hậu Giang */,
                      ),
                      FFLocalizations.of(context).getText(
                        '0mc4x29e' /* TP. Hồ Chí Minh */,
                      ),
                      FFLocalizations.of(context).getText(
                        '5m5as6cz' /* New Jersey */,
                      ),
                      FFLocalizations.of(context).getText(
                        '504kmmft' /* New Mexico */,
                      ),
                      FFLocalizations.of(context).getText(
                        '4762kvp2' /* Hòa Bình */,
                      ),
                      FFLocalizations.of(context).getText(
                        'd19nr4mi' /* North Carolina */,
                      ),
                      FFLocalizations.of(context).getText(
                        'hllyyupp' /* Khánh Hòa */,
                      ),
                      FFLocalizations.of(context).getText(
                        'fpju2q90' /* Kiên Giang */,
                      ),
                      FFLocalizations.of(context).getText(
                        '5dp7ypl3' /* Kon Tum */,
                      ),
                      FFLocalizations.of(context).getText(
                        'ahbpjgga' /* Lai Châu */,
                      ),
                      FFLocalizations.of(context).getText(
                        'bjfetk72' /* Lâm Đồng */,
                      ),
                      FFLocalizations.of(context).getText(
                        '0e832ech' /* Lạng Sơn */,
                      ),
                      FFLocalizations.of(context).getText(
                        '3ux7it6c' /* Lào Cai */,
                      ),
                      FFLocalizations.of(context).getText(
                        '3pn49k5z' /* Long An */,
                      ),
                      FFLocalizations.of(context).getText(
                        'okzc7l70' /* Nam Định */,
                      ),
                      FFLocalizations.of(context).getText(
                        'uurvajhn' /* Nghệ An */,
                      ),
                      FFLocalizations.of(context).getText(
                        'gopdjgvf' /* Ninh Bình */,
                      ),
                      FFLocalizations.of(context).getText(
                        'jlg2lexp' /* Ninh Thuận */,
                      ),
                      FFLocalizations.of(context).getText(
                        'z081r46y' /* Phú Thọ */,
                      ),
                      FFLocalizations.of(context).getText(
                        'uov5m3ra' /* Phú Yên */,
                      ),
                      FFLocalizations.of(context).getText(
                        '8coqvhi6' /* Quảng Bình */,
                      ),
                      FFLocalizations.of(context).getText(
                        'x3jur1no' /* Quảng Nam */,
                      ),
                      FFLocalizations.of(context).getText(
                        'k2ixem7y' /* Quảng Ngãi */,
                      )
                    ],
                    onChanged: (val) => setState(() => _model.stateValue = val),
                    width: double.infinity,
                    height: 56.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF14181B),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    hintText: FFLocalizations.of(context).getText(
                      'rsai1bkl' /* Quảng Ninh */,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF57636C),
                      size: 15.0,
                    ),
                    fillColor: Colors.white,
                    elevation: 2.0,
                    borderColor: const Color(0xFFE0E3E7),
                    borderWidth: 2.0,
                    borderRadius: 8.0,
                    margin:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 12.0, 4.0),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                  child: TextFormField(
                    controller: _model.myBioTextController ??=
                        TextEditingController(
                      text: columnUsersRecord.bio,
                    ),
                    focusNode: _model.myBioFocusNode,
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      hintText: FFLocalizations.of(context).getText(
                        'sbrm61sw' /* Your bio */,
                      ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E3E7),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF4B39EF),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF14181B),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    validator: _model.myBioTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: StreamBuilder<UsersRecord>(
                      stream: UsersRecord.getDocument(widget.userRef!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final buttonUsersRecord = snapshot.data!;
                        return FFButtonWidget(
                          onPressed: () async {
                            await widget.userRef!.update(createUsersRecordData(
                              displayName: _model.yourNameTextController.text,
                              photoUrl: _model.uploadedFileUrl,
                              phoneNumber: _model.phoneTextController.text,
                              bio: _model.myBioTextController.text,
                              city: _model.stateValue,
                            ));

                            context.pushNamed('profilePage');
                          },
                          text: FFLocalizations.of(context).getText(
                            'tc5a7s1v' /* Cập nhật */,
                          ),
                          options: FFButtonOptions(
                            width: 270.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            elevation: 2.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
