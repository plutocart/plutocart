package com.example.plutocart.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "account")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_account", nullable = false)
    private Integer id;

    @Column(name = "user_name", nullable = false, length = 45)
    private String userName;

    @Column(name = "imei", nullable = false, length = 15)
    private String imei;

    @Column(name = "email", length = 50)
    private String email;

    @Column(name = "password", length = 100)
    private String password;

    @Lob
    @Column(name = "account_role", nullable = false)
    private String accountRole;

}