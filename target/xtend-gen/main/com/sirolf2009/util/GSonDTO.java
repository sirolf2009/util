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
                final Function1<MutableParameterDeclaration, String> _function = new Function1<MutableParameterDeclaration, String>() {
                  public String apply(final MutableParameterDeclaration it) {
                    String _xifexpression = null;
                    TypeReference _type = it.getType();
                    TypeReference _newTypeReference = context.newTypeReference(String.class);
                    boolean _equals = Objects.equal(_type, _newTypeReference);
                    if (_equals) {
                      StringConcatenation _builder = new StringConcatenation();
                      TypeReference _type_1 = it.getType();
                      _builder.append(_type_1);
                      _builder.append(" ");
                      String _simpleName = it.getSimpleName();
                      _builder.append(_simpleName);
                      _builder.append(" = object.get(\"");
                      String _simpleName_1 = it.getSimpleName();
                      _builder.append(_simpleName_1);
                      _builder.append("\").getAsString();");
                      _xifexpression = _builder.toString();
                    } else {
                      String _xifexpression_1 = null;
                      TypeReference _type_2 = it.getType();
                      TypeReference _newTypeReference_1 = context.newTypeReference(BigDecimal.class);
                      boolean _equals_1 = Objects.equal(_type_2, _newTypeReference_1);
                      if (_equals_1) {
                        StringConcatenation _builder_1 = new StringConcatenation();
                        TypeReference _type_3 = it.getType();
                        _builder_1.append(_type_3);
                        _builder_1.append(" ");
                        String _simpleName_2 = it.getSimpleName();
                        _builder_1.append(_simpleName_2);
                        _builder_1.append(" = object.get(\"");
                        String _simpleName_3 = it.getSimpleName();
                        _builder_1.append(_simpleName_3);
                        _builder_1.append("\").getAsBigDecimal();");
                        _xifexpression_1 = _builder_1.toString();
                      } else {
                        String _xifexpression_2 = null;
                        TypeReference _type_4 = it.getType();
                        TypeReference _newTypeReference_2 = context.newTypeReference(BigInteger.class);
                        boolean _equals_2 = Objects.equal(_type_4, _newTypeReference_2);
                        if (_equals_2) {
                          StringConcatenation _builder_2 = new StringConcatenation();
                          TypeReference _type_5 = it.getType();
                          _builder_2.append(_type_5);
                          _builder_2.append(" ");
                          String _simpleName_4 = it.getSimpleName();
                          _builder_2.append(_simpleName_4);
                          _builder_2.append(" = object.get(\"");
                          String _simpleName_5 = it.getSimpleName();
                          _builder_2.append(_simpleName_5);
                          _builder_2.append("\").getAsBigInteger();");
                          _xifexpression_2 = _builder_2.toString();
                        } else {
                          String _xifexpression_3 = null;
                          TypeReference _type_6 = it.getType();
                          TypeReference _newTypeReference_3 = context.newTypeReference(Number.class);
                          boolean _equals_3 = Objects.equal(_type_6, _newTypeReference_3);
                          if (_equals_3) {
                            StringConcatenation _builder_3 = new StringConcatenation();
                            TypeReference _type_7 = it.getType();
                            _builder_3.append(_type_7);
                            _builder_3.append(" ");
                            String _simpleName_6 = it.getSimpleName();
                            _builder_3.append(_simpleName_6);
                            _builder_3.append(" = object.get(\"");
                            String _simpleName_7 = it.getSimpleName();
                            _builder_3.append(_simpleName_7);
                            _builder_3.append("\").getAsNumber();");
                            _xifexpression_3 = _builder_3.toString();
                          } else {
                            String _xifexpression_4 = null;
                            if ((Objects.equal(it.getType(), context.newTypeReference(Boolean.class)) || Objects.equal(it.getType(), context.newTypeReference(boolean.class)))) {
                              StringConcatenation _builder_4 = new StringConcatenation();
                              TypeReference _type_8 = it.getType();
                              _builder_4.append(_type_8);
                              _builder_4.append(" ");
                              String _simpleName_8 = it.getSimpleName();
                              _builder_4.append(_simpleName_8);
                              _builder_4.append(" = object.get(\"");
                              String _simpleName_9 = it.getSimpleName();
                              _builder_4.append(_simpleName_9);
                              _builder_4.append("\").getAsBoolean();");
                              _xifexpression_4 = _builder_4.toString();
                            } else {
                              String _xifexpression_5 = null;
                              if ((Objects.equal(it.getType(), context.newTypeReference(Byte.class)) || Objects.equal(it.getType(), context.newTypeReference(byte.class)))) {
                                StringConcatenation _builder_5 = new StringConcatenation();
                                TypeReference _type_9 = it.getType();
                                _builder_5.append(_type_9);
                                _builder_5.append(" ");
                                String _simpleName_10 = it.getSimpleName();
                                _builder_5.append(_simpleName_10);
                                _builder_5.append(" = object.get(\"");
                                String _simpleName_11 = it.getSimpleName();
                                _builder_5.append(_simpleName_11);
                                _builder_5.append("\").getAsByte();");
                                _xifexpression_5 = _builder_5.toString();
                              } else {
                                String _xifexpression_6 = null;
                                if ((Objects.equal(it.getType(), context.newTypeReference(Character.class)) || Objects.equal(it.getType(), context.newTypeReference(char.class)))) {
                                  StringConcatenation _builder_6 = new StringConcatenation();
                                  TypeReference _type_10 = it.getType();
                                  _builder_6.append(_type_10);
                                  _builder_6.append(" ");
                                  String _simpleName_12 = it.getSimpleName();
                                  _builder_6.append(_simpleName_12);
                                  _builder_6.append(" = object.get(\"");
                                  String _simpleName_13 = it.getSimpleName();
                                  _builder_6.append(_simpleName_13);
                                  _builder_6.append("\").getAsCharacter();");
                                  _xifexpression_6 = _builder_6.toString();
                                } else {
                                  String _xifexpression_7 = null;
                                  if ((Objects.equal(it.getType(), context.newTypeReference(Double.class)) || Objects.equal(it.getType(), context.newTypeReference(double.class)))) {
                                    StringConcatenation _builder_7 = new StringConcatenation();
                                    TypeReference _type_11 = it.getType();
                                    _builder_7.append(_type_11);
                                    _builder_7.append(" ");
                                    String _simpleName_14 = it.getSimpleName();
                                    _builder_7.append(_simpleName_14);
                                    _builder_7.append(" = object.get(\"");
                                    String _simpleName_15 = it.getSimpleName();
                                    _builder_7.append(_simpleName_15);
                                    _builder_7.append("\").getAsDouble();");
                                    _xifexpression_7 = _builder_7.toString();
                                  } else {
                                    String _xifexpression_8 = null;
                                    if ((Objects.equal(it.getType(), context.newTypeReference(Float.class)) || Objects.equal(it.getType(), context.newTypeReference(float.class)))) {
                                      StringConcatenation _builder_8 = new StringConcatenation();
                                      TypeReference _type_12 = it.getType();
                                      _builder_8.append(_type_12);
                                      _builder_8.append(" ");
                                      String _simpleName_16 = it.getSimpleName();
                                      _builder_8.append(_simpleName_16);
                                      _builder_8.append(" = object.get(\"");
                                      String _simpleName_17 = it.getSimpleName();
                                      _builder_8.append(_simpleName_17);
                                      _builder_8.append("\").getAsFloat();");
                                      _xifexpression_8 = _builder_8.toString();
                                    } else {
                                      String _xifexpression_9 = null;
                                      if ((Objects.equal(it.getType(), context.newTypeReference(Integer.class)) || Objects.equal(it.getType(), context.newTypeReference(int.class)))) {
                                        StringConcatenation _builder_9 = new StringConcatenation();
                                        TypeReference _type_13 = it.getType();
                                        _builder_9.append(_type_13);
                                        _builder_9.append(" ");
                                        String _simpleName_18 = it.getSimpleName();
                                        _builder_9.append(_simpleName_18);
                                        _builder_9.append(" = object.get(\"");
                                        String _simpleName_19 = it.getSimpleName();
                                        _builder_9.append(_simpleName_19);
                                        _builder_9.append("\").getAsInt();");
                                        _xifexpression_9 = _builder_9.toString();
                                      } else {
                                        String _xifexpression_10 = null;
                                        if ((Objects.equal(it.getType(), context.newTypeReference(Long.class)) || Objects.equal(it.getType(), context.newTypeReference(long.class)))) {
                                          StringConcatenation _builder_10 = new StringConcatenation();
                                          TypeReference _type_14 = it.getType();
                                          _builder_10.append(_type_14);
                                          _builder_10.append(" ");
                                          String _simpleName_20 = it.getSimpleName();
                                          _builder_10.append(_simpleName_20);
                                          _builder_10.append(" = object.get(\"");
                                          String _simpleName_21 = it.getSimpleName();
                                          _builder_10.append(_simpleName_21);
                                          _builder_10.append("\").getAsLong();");
                                          _xifexpression_10 = _builder_10.toString();
                                        } else {
                                          String _xifexpression_11 = null;
                                          if ((Objects.equal(it.getType(), context.newTypeReference(Short.class)) || Objects.equal(it.getType(), context.newTypeReference(short.class)))) {
                                            StringConcatenation _builder_11 = new StringConcatenation();
                                            TypeReference _type_15 = it.getType();
                                            _builder_11.append(_type_15);
                                            _builder_11.append(" ");
                                            String _simpleName_22 = it.getSimpleName();
                                            _builder_11.append(_simpleName_22);
                                            _builder_11.append(" = object.get(\"");
                                            String _simpleName_23 = it.getSimpleName();
                                            _builder_11.append(_simpleName_23);
                                            _builder_11.append("\").getAsShort();");
                                            _xifexpression_11 = _builder_11.toString();
                                          } else {
                                            StringConcatenation _builder_12 = new StringConcatenation();
                                            TypeReference _type_16 = it.getType();
                                            _builder_12.append(_type_16);
                                            _builder_12.append(" ");
                                            String _simpleName_24 = it.getSimpleName();
                                            _builder_12.append(_simpleName_24);
                                            _builder_12.append(" = context.deserialize(object.get(\"");
                                            String _simpleName_25 = it.getSimpleName();
                                            _builder_12.append(_simpleName_25);
                                            _builder_12.append("\"), ");
                                            TypeReference _type_17 = it.getType();
                                            _builder_12.append(_type_17);
                                            _builder_12.append(".class);");
                                            _xifexpression_11 = _builder_12.toString();
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
                    return _xifexpression;
                  }
                };
                String _join = IterableExtensions.join(IterableExtensions.map(constructor.getParameters(), _function), "\n");
                _builder.append(_join);
                _builder.newLineIfNotEmpty();
                _builder.append("return new ");
                _builder.append(annotatedClass);
                _builder.append("(");
                final Function1<MutableParameterDeclaration, String> _function_1 = new Function1<MutableParameterDeclaration, String>() {
                  public String apply(final MutableParameterDeclaration it) {
                    return it.getSimpleName();
                  }
                };
                String _join_1 = IterableExtensions.join(IterableExtensions.map(constructor.getParameters(), _function_1), ", ");
                _builder.append(_join_1);
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
