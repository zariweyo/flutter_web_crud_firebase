// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';




class _TextFieldSelectionGestureDetectorBuilderBIS extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilderBIS({
    @required _TextFieldBISState state,
  }) : _state = state,
       super(delegate: state);

  final _TextFieldBISState _state;


  @override
  void onDragSelectionStart(DragStartDetails details) {
    //Avoid to prevent BUG
    //super.onDragSelectionStart(details)
  }

  @override
  void onTapDown(TapDownDetails details) {
    /*
    print(renderEditable.offset.pixels);
    //Offset _off = Offset(0,renderEditable.offset)
    TapDownDetails _details = TapDownDetails(
      globalPosition: details.globalPosition + Offset(0,renderEditable.offset.pixels),
      localPosition: details.localPosition,
      kind: details.kind
    );
    */
    
    super.onTapDown(details);
  }

  @override
  void onDragSelectionUpdate(DragStartDetails startDetails, DragUpdateDetails updateDetails) {
    //Avoid to prevent BUG

    
/*
    print(renderEditable.selection);
    print(startDetails.globalPosition);
    print(startDetails.localPosition);
    print(renderEditable.offset);
    //renderEditable.selectP
    
    renderEditable.selectPositionAt(
            from: startDetails.localPosition,
            to: updateDetails.localPosition,
            cause: SelectionChangedCause.drag,
          );
    */
    
  }

  @protected
  void onDragSelectionEnd(DragEndDetails details) {
    
    //Avoid to prevent BUG
  }

  @override
  void onForcePressStart(ForcePressDetails details) {
    
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    
    // Not required.
  }

  @override
  void onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details) {

    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        default:

          
          renderEditable.selectWordsInRange(
            from: details.globalPosition - details.offsetFromOrigin,
            to: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          
          break;
      }
    }
  }

  @override
  void onSingleTapUp(TapUpDetails details) {
    editableText.hideToolbar();
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
          renderEditable.selectWordEdge(cause: SelectionChangedCause.tap);
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        default:
          //renderEditable.selectPosition(cause: SelectionChangedCause.tap);
          break;
      }
    }
    _state._requestKeyboard();
    if (_state.widget.onTap != null)
      _state.widget.onTap();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        default:
          renderEditable.selectWord(cause: SelectionChangedCause.longPress);
          Feedback.forLongPress(_state.context);
          break;
      }
    }
  }
}

class TextFieldBIS extends StatefulWidget {
  
  const TextFieldBIS({
    Key key,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    TextInputType keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    ToolbarOptions toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = false,
    this.onTap,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
  }) : assert(textAlign != null),
       assert(readOnly != null),
       assert(autofocus != null),
       assert(obscureText != null),
       assert(autocorrect != null),
       assert(enableSuggestions != null),
       assert(enableInteractiveSelection != null),
       assert(maxLengthEnforced != null),
       assert(scrollPadding != null),
       assert(dragStartBehavior != null),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         'minLines can\'t be greater than maxLines',
       ),
       assert(expands != null),
       assert(
         !expands || (maxLines == null && minLines == null),
         'minLines and maxLines must be null when expands is true.',
       ),
       assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
       assert(maxLength == null || maxLength == TextFieldBIS.noMaxLength || maxLength > 0),
       keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
       toolbarOptions = toolbarOptions ?? (obscureText ?
         const ToolbarOptions(
           selectAll: true,
           paste: true,
         ) :
         const ToolbarOptions(
           copy: true,
           cut: true,
           selectAll: true,
           paste: true,
         )),
       super(key: key);

  
  final TextEditingController controller;

  final FocusNode focusNode;

  
  final InputDecoration decoration;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextDirection textDirection;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int maxLines;
  final int minLines;
  final bool expands;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  static const int noMaxLength = -1;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  bool get selectionEnabled => enableInteractiveSelection;
  final GestureTapCallback onTap;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollPhysics scrollPhysics;
  final ScrollController scrollController;

  @override
  _TextFieldBISState createState() => _TextFieldBISState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties.add(DiagnosticsProperty<InputDecoration>('decoration', decoration, defaultValue: const InputDecoration()));
    properties.add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType, defaultValue: TextInputType.text));
    properties.add(DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('enableSuggestions', enableSuggestions, defaultValue: true));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
    properties.add(FlagProperty('maxLengthEnforced', value: maxLengthEnforced, defaultValue: true, ifFalse: 'maxLength not enforced'));
    properties.add(EnumProperty<TextInputAction>('textInputAction', textInputAction, defaultValue: null));
    properties.add(EnumProperty<TextCapitalization>('textCapitalization', textCapitalization, defaultValue: TextCapitalization.none));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start));
    properties.add(DiagnosticsProperty<TextAlignVertical>('textAlignVertical', textAlignVertical, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
    properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius, defaultValue: null));
    properties.add(ColorProperty('cursorColor', cursorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Brightness>('keyboardAppearance', keyboardAppearance, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('scrollPadding', scrollPadding, defaultValue: const EdgeInsets.all(20.0)));
    properties.add(FlagProperty('selectionEnabled', value: selectionEnabled, defaultValue: true, ifFalse: 'selection disabled'));
    properties.add(DiagnosticsProperty<ScrollController>('scrollController', scrollController, defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>('scrollPhysics', scrollPhysics, defaultValue: null));
  }
}

class _TextFieldBISState extends State<TextFieldBIS> implements TextSelectionGestureDetectorBuilderDelegate {
  TextEditingController _controller;
  TextEditingController get _effectiveController => widget.controller ?? _controller;

  FocusNode _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  bool _isHovering = false;

  bool get needsCounter => widget.maxLength != null
    && widget.decoration != null
    && widget.decoration.counterText == null;

  bool _showSelectionHandles = true;

  _TextFieldSelectionGestureDetectorBuilderBIS _selectionGestureDetectorBuilder;

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.selectionEnabled;
  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  bool get _isEnabled =>  widget.enabled ?? widget.decoration?.enabled ?? true;

  int get _currentLength => _effectiveController.value.text.runes.length;

  InputDecoration _getEffectiveDecoration() {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final InputDecoration effectiveDecoration = (widget.decoration ?? const InputDecoration())
      .applyDefaults(themeData.inputDecorationTheme)
      .copyWith(
        enabled: widget.enabled,
        hintMaxLines: widget.decoration?.hintMaxLines ?? widget.maxLines,
      );

    // No need to build anything if counter or counterText were given directly.
    if (effectiveDecoration.counter != null || effectiveDecoration.counterText != null)
      return effectiveDecoration;

    // If buildCounter was provided, use it to generate a counter widget.
    Widget counter;
    final int currentLength = _currentLength;
    if (effectiveDecoration.counter == null
        && effectiveDecoration.counterText == null
        && widget.buildCounter != null) {
      final bool isFocused = _effectiveFocusNode.hasFocus;
      counter = Semantics(
        container: true,
        liveRegion: isFocused,
        child: widget.buildCounter(
          context,
          currentLength: currentLength,
          maxLength: widget.maxLength,
          isFocused: isFocused,
        ),
      );
      return effectiveDecoration.copyWith(counter: counter);
    }

    if (widget.maxLength == null)
      return effectiveDecoration; // No counter widget

    String counterText = '$currentLength';
    String semanticCounterText = '';

    // Handle a real maxLength (positive number)
    if (widget.maxLength > 0) {
      // Show the maxLength in the counter
      counterText += '/${widget.maxLength}';
      final int remaining = (widget.maxLength - currentLength).clamp(0, widget.maxLength);
      semanticCounterText = localizations.remainingTextFieldCharacterCount(remaining);

      // Handle length exceeds maxLength
      if (_effectiveController.value.text.runes.length > widget.maxLength) {
        return effectiveDecoration.copyWith(
          errorText: effectiveDecoration.errorText ?? '',
          counterStyle: effectiveDecoration.errorStyle
            ?? themeData.textTheme.caption.copyWith(color: themeData.errorColor),
          counterText: counterText,
          semanticCounterText: semanticCounterText,
        );
      }
    }

    return effectiveDecoration.copyWith(
      counterText: counterText,
      semanticCounterText: semanticCounterText,
    );
  }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _TextFieldSelectionGestureDetectorBuilderBIS(state: this);
    if (widget.controller == null) {
      _controller = TextEditingController();
    }
    _effectiveFocusNode.canRequestFocus = _isEnabled;
  }

  @override
  void didUpdateWidget(TextFieldBIS oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _controller = TextEditingController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null)
      _controller = null;
    _effectiveFocusNode.canRequestFocus = _isEnabled;
    if (_effectiveFocusNode.hasFocus && widget.readOnly != oldWidget.readOnly) {
      if(_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  EditableTextState get _editableText => editableTextKey.currentState;

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar)
      return false;

    if (cause == SelectionChangedCause.keyboard)
      return false;

    if (widget.readOnly && _effectiveController.selection.isCollapsed)
      return false;

    if (cause == SelectionChangedCause.longPress)
      return true;

    if (_effectiveController.text.isNotEmpty)
      return true;

    return false;
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.base);
        }
        return;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      default:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.base);
        }
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {

    
    
    if (_effectiveController.selection.isCollapsed) {
      _editableText.toggleToolbar();
    }
  }

  void _handleHover(bool hovering) {
    
    if (hovering != _isHovering) {
      setState(() {
        return _isHovering = hovering;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    // TODO(jonahwilliams): uncomment out this check once we have migrated tests.
    // assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    assert(
      !(widget.style != null && widget.style.inherit == false &&
        (widget.style.fontSize == null || widget.style.textBaseline == null)),
      'inherit false style must supply fontSize and textBaseline',
    );

    final ThemeData themeData = Theme.of(context);
    final TextStyle style = themeData.textTheme.subhead.merge(widget.style);
    final Brightness keyboardAppearance = widget.keyboardAppearance ?? themeData.primaryColorBrightness;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;
    final List<TextInputFormatter> formatters = widget.inputFormatters ?? <TextInputFormatter>[];
    if (widget.maxLength != null && widget.maxLengthEnforced)
      formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));

    TextSelectionControls textSelectionControls;
    bool paintCursorAboveText;
    bool cursorOpacityAnimates;
    Offset cursorOffset;
    Color cursorColor = widget.cursorColor;
    Radius cursorRadius = widget.cursorRadius;

    switch (themeData.platform) {
      case TargetPlatform.iOS:
        forcePressEnabled = true;
        textSelectionControls = cupertinoTextSelectionControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = true;
        cursorColor ??= CupertinoTheme.of(context).primaryColor;
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.of(context).devicePixelRatio, 0);
        break;

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      default:
        forcePressEnabled = false;
        textSelectionControls = materialTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor ??= themeData.cursorColor;
        break;
    }

    
    Widget child = RepaintBoundary(
      child: EditableText(
        key: editableTextKey,
        readOnly: widget.readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: widget.showCursor,
        showSelectionHandles: _showSelectionHandles,
        controller: controller,
        focusNode: focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        selectionColor: themeData.textSelectionColor,
        selectionControls: widget.selectionEnabled ? textSelectionControls : null,
        onChanged: widget.onChanged,
        onSelectionChanged: _handleSelectionChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        onSelectionHandleTapped: _handleSelectionHandleTapped,
        inputFormatters: formatters,
        rendererIgnoresPointer: true,
        cursorWidth: widget.cursorWidth,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        cursorOpacityAnimates: false,
        cursorOffset: cursorOffset,
        paintCursorAboveText: paintCursorAboveText,
        backgroundCursorColor: CupertinoColors.inactiveGray,
        scrollPadding: widget.scrollPadding,
        keyboardAppearance: keyboardAppearance,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        dragStartBehavior: widget.dragStartBehavior,
        scrollController: widget.scrollController,
        scrollPhysics: widget.scrollPhysics
      ),
    );

    if (widget.decoration != null) {
      child = AnimatedBuilder(
        animation: Listenable.merge(<Listenable>[ focusNode, controller ]),
        builder: (BuildContext context, Widget child) {
          return InputDecorator(
            decoration: _getEffectiveDecoration(),
            baseStyle: widget.style,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            isHovering: _isHovering,
            isFocused: focusNode.hasFocus,
            isEmpty: controller.value.text.isEmpty,
            expands: widget.expands,
            child: child,
          );
        },
        child: child,
      );
    }
    return IgnorePointer(
      ignoring: !_isEnabled,
      child: MouseRegion(
        onEnter: (PointerEnterEvent event) => _handleHover(true),
        onExit: (PointerExitEvent event) => _handleHover(false),
        child: AnimatedBuilder(
          animation: controller, // changes the _currentLength
          builder: (BuildContext context, Widget child) {
            return Semantics(
              maxValueLength: widget.maxLengthEnforced && widget.maxLength != null && widget.maxLength > 0
                  ? widget.maxLength
                  : null,
              currentValueLength: _currentLength,
              onTap: () {
                if (!_effectiveController.selection.isValid)
                  _effectiveController.selection = TextSelection.collapsed(offset: _effectiveController.text.length);
                _requestKeyboard();
              },
              child: child,
            );
          },
          child: _selectionGestureDetectorBuilder.buildGestureDetector(
            behavior: HitTestBehavior.translucent,
            child: child,
          ),
        ),
      ),
    );
  }
}
