package com.sirolf2009.util;

import com.google.common.base.Objects;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Collections;
import java.util.List;
import org.eclipse.xtend.lib.macro.AbstractClassProcessor;
import org.eclipse.xtend.lib.macro.Active;
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext;
import org.eclipse.xtend.lib.macro.TransformationContext;
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration;
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration;
import org.eclipse.xtend.lib.macro.declaration.MutableConstructorDeclaration;
import org.eclipse.xtend.lib.macro.declaration.MutableMethodDeclaration;
import org.eclipse.xtend.lib.macro.declaration.MutableParameterDeclaration;
import org.eclipse.xtend.lib.macro.declaration.TypeReference;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtend2.lib.StringConcatenationClient;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@Active(GSonDTO.GSonDTOProcessor.class)
public @interface GSonDTO {
  public static class GSonDTOProcessor extends AbstractClassProcessor {
    public void doRegisterGlobals(final ClassDeclaration annotatedClass, final RegisterGlobalsContext context) {
      context.registerClass(this.getSerializerName(annotatedClass));
    }
    
    public void doTransform(final MutableClassDeclaration annotatedClass, @Extension final TransformationContext context) {
      if (((IterableExtensions.size(annotatedClass.getDeclaredConstructors()) > 1) || (IterableExtensions.size(annotatedClass.getDeclaredConstructors()) == 0))) {
        context.addError(annotatedClass, "Only one constructor is allowed");
      } else {
        final MutableClassDeclaration serializer = context.findClass(this.getSerializerName(annotatedClass));
        final MutableConstructorDeclaration constructor = ((MutableConstructorDeclaration[])Conversions.unwrapArray(annotatedClass.getDeclaredConstructors(), MutableConstructorDeclaration.class))[0];
        TypeReference _newTypeReference = context.newTypeReference(JsonDeserializer.class, context.newSelfTypeReference(annotatedClass));
        serializer.setImplementedInterfaces(Collections.<TypeReference>unmodifiableList(CollectionLiterals.<TypeReference>newArrayList(_newTypeReference)));
        final Procedure1<MutableMethodDeclaration> _function = new Procedure1<MutableMethodDeclaration>() {
          public void apply(final MutableMethodDeclaration it) {
            it.setReturnType(context.newSelfTypeReference(annotatedClass));
            it.addParameter("json", context.newTypeReference(JsonElement.class));
            it.addParameter("typeOfT", context.newTypeReference(Type.class));
            it.addParameter("context", context.newTypeReference(JsonDeserializationContext.class));
            TypeReference _newTypeReference = context.newTypeReference(JsonParseException.class);
            it.setExceptions(new TypeReference[] { _newTypeReference });
            StringConcatenationClient _client = new StringConcatenationClient() {
              @Override
              protected void appendTo(StringConcatenationClient.TargetStringConcatenation _builder) {
                TypeReference _newTypeReference = context.newTypeReference(JsonObject.class);
                _builder.append(_newTypeReference);
                _builder.append(" object = json.getAsJsonObject();");
                _builder.newLineIfNotEmpty();
                {
                  Iterable<? extends MutableParameterDeclaration> _parameters = constructor.getParameters();
                  for(final MutableParameterDeclaration type : _parameters) {
                    CharSequence _xifexpression = null;
                    TypeReference _newTypeReference_1 = context.newTypeReference(String.class);
                    boolean _equals = Objects.equal(type, _newTypeReference_1);
                    if (_equals) {
                      StringConcatenation _builder_1 = new StringConcatenation();
                      String _qualifiedName = type.getType().getType().getQualifiedName();
                      _builder_1.append(_qualifiedName);
                      _builder_1.append(" ");
                      String _simpleName = type.getSimpleName();
                      _builder_1.append(_simpleName);
                      _builder_1.append(" = object.get(\"");
                      String _simpleName_1 = type.getSimpleName();
                      _builder_1.append(_simpleName_1);
                      _builder_1.append("\").getAsString();");
                      _xifexpression = _builder_1;
                    } else {
                      CharSequence _xifexpression_1 = null;
                      TypeReference _newTypeReference_2 = context.newTypeReference(BigDecimal.class);
                      boolean _equals_1 = Objects.equal(type, _newTypeReference_2);
                      if (_equals_1) {
                        StringConcatenation _builder_2 = new StringConcatenation();
                        String _qualifiedName_1 = type.getType().getType().getQualifiedName();
                        _builder_2.append(_qualifiedName_1);
                        _builder_2.append(" ");
                        String _simpleName_2 = type.getSimpleName();
                        _builder_2.append(_simpleName_2);
                        _builder_2.append(" = object.get(\"");
                        String _simpleName_3 = type.getSimpleName();
                        _builder_2.append(_simpleName_3);
                        _builder_2.append("\").getAsBigDecimal();");
                        _xifexpression_1 = _builder_2;
                      } else {
                        CharSequence _xifexpression_2 = null;
                        TypeReference _newTypeReference_3 = context.newTypeReference(BigInteger.class);
                        boolean _equals_2 = Objects.equal(type, _newTypeReference_3);
                        if (_equals_2) {
                          StringConcatenation _builder_3 = new StringConcatenation();
                          String _qualifiedName_2 = type.getType().getType().getQualifiedName();
                          _builder_3.append(_qualifiedName_2);
                          _builder_3.append(" ");
                          String _simpleName_4 = type.getSimpleName();
                          _builder_3.append(_simpleName_4);
                          _builder_3.append(" = object.get(\"");
                          String _simpleName_5 = type.getSimpleName();
                          _builder_3.append(_simpleName_5);
                          _builder_3.append("\").getAsBigInteger();");
                          _xifexpression_2 = _builder_3;
                        } else {
                          CharSequence _xifexpression_3 = null;
                          TypeReference _newTypeReference_4 = context.newTypeReference(Number.class);
                          boolean _equals_3 = Objects.equal(type, _newTypeReference_4);
                          if (_equals_3) {
                            StringConcatenation _builder_4 = new StringConcatenation();
                            String _qualifiedName_3 = type.getType().getType().getQualifiedName();
                            _builder_4.append(_qualifiedName_3);
                            _builder_4.append(" ");
                            String _simpleName_6 = type.getSimpleName();
                            _builder_4.append(_simpleName_6);
                            _builder_4.append(" = object.get(\"");
                            String _simpleName_7 = type.getSimpleName();
                            _builder_4.append(_simpleName_7);
                            _builder_4.append("\").getAsNumber();");
                            _xifexpression_3 = _builder_4;
                          } else {
                            CharSequence _xifexpression_4 = null;
                            if ((Objects.equal(type, context.newTypeReference(Boolean.class)) || Objects.equal(type, context.newTypeReference(boolean.class)))) {
                              StringConcatenation _builder_5 = new StringConcatenation();
                              String _qualifiedName_4 = type.getType().getType().getQualifiedName();
                              _builder_5.append(_qualifiedName_4);
                              _builder_5.append(" ");
                              String _simpleName_8 = type.getSimpleName();
                              _builder_5.append(_simpleName_8);
                              _builder_5.append(" = object.get(\"");
                              String _simpleName_9 = type.getSimpleName();
                              _builder_5.append(_simpleName_9);
                              _builder_5.append("\").getAsBoolean();");
                              _xifexpression_4 = _builder_5;
                            } else {
                              CharSequence _xifexpression_5 = null;
                              if ((Objects.equal(type, context.newTypeReference(Byte.class)) || Objects.equal(type, context.newTypeReference(byte.class)))) {
                                StringConcatenation _builder_6 = new StringConcatenation();
                                String _qualifiedName_5 = type.getType().getType().getQualifiedName();
                                _builder_6.append(_qualifiedName_5);
                                _builder_6.append(" ");
                                String _simpleName_10 = type.getSimpleName();
                                _builder_6.append(_simpleName_10);
                                _builder_6.append(" = object.get(\"");
                                String _simpleName_11 = type.getSimpleName();
                                _builder_6.append(_simpleName_11);
                                _builder_6.append("\").getAsByte();");
                                _xifexpression_5 = _builder_6;
                              } else {
                                CharSequence _xifexpression_6 = null;
                                if ((Objects.equal(type, context.newTypeReference(Character.class)) || Objects.equal(type, context.newTypeReference(char.class)))) {
                                  StringConcatenation _builder_7 = new StringConcatenation();
                                  String _qualifiedName_6 = type.getType().getType().getQualifiedName();
                                  _builder_7.append(_qualifiedName_6);
                                  _builder_7.append(" ");
                                  String _simpleName_12 = type.getSimpleName();
                                  _builder_7.append(_simpleName_12);
                                  _builder_7.append(" = object.get(\"");
                                  String _simpleName_13 = type.getSimpleName();
                                  _builder_7.append(_simpleName_13);
                                  _builder_7.append("\").getAsCharacter();");
                                  _xifexpression_6 = _builder_7;
                                } else {
                                  CharSequence _xifexpression_7 = null;
                                  if ((Objects.equal(type, context.newTypeReference(Double.class)) || Objects.equal(type, context.newTypeReference(double.class)))) {
                                    StringConcatenation _builder_8 = new StringConcatenation();
                                    String _qualifiedName_7 = type.getType().getType().getQualifiedName();
                                    _builder_8.append(_qualifiedName_7);
                                    _builder_8.append(" ");
                                    String _simpleName_14 = type.getSimpleName();
                                    _builder_8.append(_simpleName_14);
                                    _builder_8.append(" = object.get(\"");
                                    String _simpleName_15 = type.getSimpleName();
                                    _builder_8.append(_simpleName_15);
                                    _builder_8.append("\").getAsDouble();");
                                    _xifexpression_7 = _builder_8;
                                  } else {
                                    CharSequence _xifexpression_8 = null;
                                    if ((Objects.equal(type, context.newTypeReference(Float.class)) || Objects.equal(type, context.newTypeReference(float.class)))) {
                                      StringConcatenation _builder_9 = new StringConcatenation();
                                      String _qualifiedName_8 = type.getType().getType().getQualifiedName();
                                      _builder_9.append(_qualifiedName_8);
                                      _builder_9.append(" ");
                                      String _simpleName_16 = type.getSimpleName();
                                      _builder_9.append(_simpleName_16);
                                      _builder_9.append(" = object.get(\"");
                                      String _simpleName_17 = type.getSimpleName();
                                      _builder_9.append(_simpleName_17);
                                      _builder_9.append("\").getAsFloat();");
                                      _xifexpression_8 = _builder_9;
                                    } else {
                                      CharSequence _xifexpression_9 = null;
                                      if ((Objects.equal(type, context.newTypeReference(Integer.class)) || Objects.equal(type, context.newTypeReference(int.class)))) {
                                        StringConcatenation _builder_10 = new StringConcatenation();
                                        String _qualifiedName_9 = type.getType().getType().getQualifiedName();
                                        _builder_10.append(_qualifiedName_9);
                                        _builder_10.append(" ");
                                        String _simpleName_18 = type.getSimpleName();
                                        _builder_10.append(_simpleName_18);
                                        _builder_10.append(" = object.get(\"");
                                        String _simpleName_19 = type.getSimpleName();
                                        _builder_10.append(_simpleName_19);
                                        _builder_10.append("\").getAsInt();");
                                        _xifexpression_9 = _builder_10;
                                      } else {
                                        CharSequence _xifexpression_10 = null;
                                        if ((Objects.equal(type, context.newTypeReference(Long.class)) || Objects.equal(type, context.newTypeReference(long.class)))) {
                                          StringConcatenation _builder_11 = new StringConcatenation();
                                          String _qualifiedName_10 = type.getType().getType().getQualifiedName();
                                          _builder_11.append(_qualifiedName_10);
                                          _builder_11.append(" ");
                                          String _simpleName_20 = type.getSimpleName();
                                          _builder_11.append(_simpleName_20);
                                          _builder_11.append(" = object.get(\"");
                                          String _simpleName_21 = type.getSimpleName();
                                          _builder_11.append(_simpleName_21);
                                          _builder_11.append("\").getAsLong();");
                                          _xifexpression_10 = _builder_11;
                                        } else {
                                          CharSequence _xifexpression_11 = null;
                                          if ((Objects.equal(type, context.newTypeReference(Short.class)) || Objects.equal(type, context.newTypeReference(short.class)))) {
                                            StringConcatenation _builder_12 = new StringConcatenation();
                                            String _qualifiedName_11 = type.getType().getType().getQualifiedName();
                                            _builder_12.append(_qualifiedName_11);
                                            _builder_12.append(" ");
                                            String _simpleName_22 = type.getSimpleName();
                                            _builder_12.append(_simpleName_22);
                                            _builder_12.append(" = object.get(\"");
                                            String _simpleName_23 = type.getSimpleName();
                                            _builder_12.append(_simpleName_23);
                                            _builder_12.append("\").getAsShort();");
                                            _xifexpression_11 = _builder_12;
                                          } else {
                                            CharSequence _xifexpression_12 = null;
                                            boolean _isAssignableFrom = type.getType().isAssignableFrom(context.newTypeReference(List.class));
                                            if (_isAssignableFrom) {
                                              StringConcatenation _builder_13 = new StringConcatenation();
                                              String _qualifiedName_12 = type.getType().getType().getQualifiedName();
                                              _builder_13.append(_qualifiedName_12);
                                              _builder_13.append(" ");
                                              String _simpleName_24 = type.getSimpleName();
                                              _builder_13.append(_simpleName_24);
                                              _builder_13.append(" = context.deserialize(object.get(\"");
                                              String _simpleName_25 = type.getSimpleName();
                                              _builder_13.append(_simpleName_25);
                                              _builder_13.append("\"), new com.google.gson.reflect.TypeToken<");
                                              String _qualifiedName_13 = type.getType().getType().getQualifiedName();
                                              _builder_13.append(_qualifiedName_13);
                                              _builder_13.append("<");
                                              String _qualifiedName_14 = type.getType().getActualTypeArguments().get(0).getType().getQualifiedName();
                                              _builder_13.append(_qualifiedName_14);
                                              _builder_13.append(">>(){}.getType());");
                                              _xifexpression_12 = _builder_13;
                                            } else {
                                              StringConcatenation _builder_14 = new StringConcatenation();
                                              String _qualifiedName_15 = type.getType().getType().getQualifiedName();
                                              _builder_14.append(_qualifiedName_15);
                                              _builder_14.append(" ");
                                              String _simpleName_26 = type.getSimpleName();
                                              _builder_14.append(_simpleName_26);
                                              _builder_14.append(" = context.deserialize(object.get(\"");
                                              String _simpleName_27 = type.getSimpleName();
                                              _builder_14.append(_simpleName_27);
                                              _builder_14.append("\"), ");
                                              String _qualifiedName_16 = type.getType().getType().getQualifiedName();
                                              _builder_14.append(_qualifiedName_16);
                                              _builder_14.append(".class);");
                                              _xifexpression_12 = _builder_14;
                                            }
                                            _xifexpression_11 = _xifexpression_12;
                                          }
                                          _xifexpression_10 = _xifexpression_11;
                                        }
                                        _xifexpression_9 = _xifexpression_10;
                                      }
                                      _xifexpression_8 = _xifexpression_9;
                                    }
                                    _xifexpression_7 = _xifexpression_8;
                                  }
                                  _xifexpression_6 = _xifexpression_7;
                                }
                                _xifexpression_5 = _xifexpression_6;
                              }
                              _xifexpression_4 = _xifexpression_5;
                            }
                            _xifexpression_3 = _xifexpression_4;
                          }
                          _xifexpression_2 = _xifexpression_3;
                        }
                        _xifexpression_1 = _xifexpression_2;
                      }
                      _xifexpression = _xifexpression_1;
                    }
                    _builder.append(_xifexpression);
                    _builder.newLineIfNotEmpty();
                  }
                }
                _builder.append("return new ");
                _builder.append(annotatedClass);
                _builder.append("(");
                final Function1<MutableParameterDeclaration, String> _function = new Function1<MutableParameterDeclaration, String>() {
                  public String apply(final MutableParameterDeclaration it) {
                    return it.getSimpleName();
                  }
                };
                String _join = IterableExtensions.join(IterableExtensions.map(constructor.getParameters(), _function), ", ");
                _builder.append(_join);
                _builder.append(");");
              }
            };
            it.setBody(_client);
          }
        };
        serializer.addMethod("deserialize", _function);
      }
    }
    
    public String getSerializerName(final ClassDeclaration annotatedClass) {
      String _qualifiedName = annotatedClass.getQualifiedName();
      return (_qualifiedName + "JsonDeserializer");
    }
  }
}
