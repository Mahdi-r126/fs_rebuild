package com.textallin.smsonlines;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.database.Cursor;
import android.provider.ContactsContract;
import android.util.Log;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import io.flutter.embedding.android.FlutterActivity;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "flutter-free-sms-app/getContacts";
    Gson gson = new Gson();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if(call.method.equals("getContacts")) {
                                result.success(getContacts(MainActivity.this, call.argument("offset"), call.argument("contactName")));
                            } else {
                                result.notImplemented();
                            }
                            // This method is invoked on the main thread.
                            // TODO
                        }
                );
    }

    public String getContacts(Activity activity, int offset, String contactName) {

        String selection = ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME_PRIMARY + " LIKE ?";
        String[] selectionArgs = new String[] { "%" + contactName + "%" };
        String sortOrder = ContactsContract.Contacts.DISPLAY_NAME_PRIMARY + " ASC LIMIT " + 20 + " OFFSET " + offset;


        Cursor cursor = activity.getContentResolver().query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null, selection, selectionArgs, sortOrder);
//        activity.startManagingCursor(cursor);

        List<Contact> contactList = new ArrayList<>();

        try {
            if (cursor != null && cursor.moveToFirst()) {
                do {
                    @SuppressLint("Range") String displayName = cursor.getString(cursor.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME));
                    @SuppressLint("Range") String phoenNumber = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
                    Contact contact = new Contact(displayName, phoenNumber);
                    contactList.add(contact);

                } while (cursor.moveToNext());
            }
        } catch (Exception e) {
            Log.e("TAG", "Error retrieving contacts", e);
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }

        Contacts contacts = new Contacts(contactList);

        return gson.toJson(contacts);
    }

    public static class Contacts {
        private final List<Contact> contacts;

        public Contacts(List<Contact> contacts) {
            this.contacts = contacts;
        }

        public List<Contact> getContacts() {
            return contacts;
        }
    }

    public static class Contact {
        private final String name;
        private final String phoneNumber;

        public Contact(String name, String phoneNumber) {
            this.name = name;
            this.phoneNumber = phoneNumber;
        }

        public String getName() {
            return name;
        }

        public String getPhoneNumber() {
            return phoneNumber;
        }
    }

}
