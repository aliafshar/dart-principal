// Copyright (c) 2012, Google Inc
// Author: afshar@google.com (Ali Afshar)

library principal;

/**
 * A single requirement that can be required or provided.
 */
class Requirement<T> {

  /**
   * The value of this requirement. Can be anything.
   */
  final T value;

  /**
   * Creates a new requirement from the given value.
   */
  Requirement(this.value);

  /**
   * Returns whether this requirement value is equal to the other.
   */
  bool operator ==(Requirement<T> other) => value == other.value;

  int get hashCode => value.hashCode;

  String toString() => 'Requirement<$value>';

}


/**
 * The base class for things requiring or providing requirements.
 */
class Principled {

  // Requirements provided or required by this principled.
  final Set reqs = new Set();

  /**
   * Adds a requirement value to this principled.
   */
  add(dynamic value) => reqs.add(new Requirement(value));

  /**
   * Adds many requirement values to this principled.
   */
  addMany(List<dynamic> values) => values.forEach(add);

  /**
   * Returns whether the other principled is contained by this one.
   */
  bool contains(Principled other) => reqs.containsAll(other.reqs);

}


/**
 * A permission containing a number of requirements.
 */
class Permission extends Principled {

  // Shortcut to requirements.
  Set get needs => reqs;

  /**
   * Creates a new Permission for a single requirement value.
   */
  Permission(dynamic value) {
    add(value);
  }

  /**
   * Creates a new permission for the given list of requirement values.
   */
  Permission.s(List<dynamic> values) {
    addMany(values);
  }

  /**
   * Returns whether this permission can be accessed by the identity.
   */
  bool allows(Identity identity) => identity.contains(this);

}


/**
 * An identity providing a number of requirements.
 */
class Identity extends Principled {

  // Shortcut to requirements.
  Set get provides => reqs;

  // User associated with this identity. Provided for implementations to use.
  dynamic user;

  // Key for this identity.
  final String key;

  /**
   * Creates a new identity for the given optional key.
   */
  Identity([this.key]);

  /**
   * Returns whether this identity has permission.
   */
  bool can(Permission permission) => contains(permission);

}

