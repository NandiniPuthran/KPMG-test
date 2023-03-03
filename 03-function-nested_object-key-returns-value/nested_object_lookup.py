def get_value_from_nested_object(nested_obj, key):
    keys = key.split('/')  # Split the key into a list of keys
    obj = nested_obj
    for k in keys:
        obj = obj.get(k)  # Get the value associated with the key
        if obj is None:
            return None  # Key doesn't exist in the object
    return obj  # Return the value associated with the key

# Example usage
obj1 = {"a": {"b": {"c": "d"}}}
key1 = "a/b/c"
print(get_value_from_nested_object(obj1, key1))  # Output: d

obj2 = {"x": {"y": {"z": "a"}}}
key2 = "x/y/z"
print(get_value_from_nested_object(obj2, key2))  # Output: a


#To test the function, below are the examples of test cases for different combinations of input objects and keys.

def test_get_value_from_nested_object():
    obj = {"a": {"b": {"c": "d"}}}
    assert get_value_from_nested_object(obj, "a/b/c") == "d"

    obj = {"x": {"y": {"z": "a"}}}
    assert get_value_from_nested_object(obj, "x/y/z") == "a"

    obj = {"a": {"b": {"c": "d"}}}
    assert get_value_from_nested_object(obj, "a/b") == {"c": "d"}

    obj = {"a": {"b": {"c": "d"}}}
    assert get_value_from_nested_object(obj, "a/b/e") == None

test_get_value_from_nested_object()
